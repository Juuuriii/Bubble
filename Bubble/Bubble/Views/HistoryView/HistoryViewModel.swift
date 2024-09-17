//
//  HistoryViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 16.09.24.
//

import Foundation
import SwiftUI



class HistoryViewModel: ObservableObject {
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
    @Published var history = [BalanceChange]()
    
    @Published var balanceChangeName = "Bob"
    @Published var balanceChangeAmount = 1.0
    @Published var balanceChangeType: BalanceChangeType = .expense
    @Published var balanceChangeCurrentBalance = 0.0
    @Published var balanceChangeDate = Date.now
    
    @Published var bubbleUser: BubbleUser?
    
    
    
    init(bubbleUser: BubbleUser?) {
        self.bubbleUser = bubbleUser
        
        
        addBalanceChangeSnapshotlistener()
    }
    
    
    func addBalanceChangeSnapshotlistener() {
        
        firestoreClient.store.collection("users")
            .document(bubbleUser?.id ?? "")
            .collection("history")
            .addSnapshotListener{ querySnapshot, error in
                
                if let error = error {
                    print(error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach{ change in
                    
                    switch change.type {
                    case .added:
                        if let data = try? change.document.data(as: BalanceChange.self) {
                            
                            withAnimation{
                                self.history.append(data)
                            }
                            
                            
                        }
                    case .modified:
                        print("How?")
                        
                    case .removed:
                        if let data = try? change.document.data(as: BalanceChange.self) {
                            
                            withAnimation{
                                self.history.removeAll{ $0.id == data.id }
                            }
                        }
                    }
                    
                    self.history = self.history.sorted{$0.date > $1.date }
                    
                }
            }
        
    }
    
    func addBalanceChange(){
        Task {
            do {
                try firestoreClient.addBalanceChange(uid: bubbleUser?.id ?? "",
                                                     name: balanceChangeName,
                                                     amount: balanceChangeAmount,
                                                     type: balanceChangeType.rawValue,
                                                     currentBalance: balanceChangeCurrentBalance,
                                                     date: balanceChangeDate)
                
                updateUserBalance()
            } catch {
                print(error)
            }
        }
    }
    
   private func updateUserBalance(){
        Task{
            do {
                try await firestoreClient.updateUserBalance(uid: bubbleUser?.id ?? "", oldAmount: bubbleUser?.balance, amount: balanceChangeAmount, type: balanceChangeType)
            } catch {
                print(error)
            }
        }
    }
    
    func deleteBalanceChange(id: String, amount: Double, type: BalanceChangeType) {
        Task{
            do {
                try await firestoreClient.updateUserBalance(uid: bubbleUser?.id ?? "", oldAmount: bubbleUser?.balance, amount: amount, type: type, delete: true)
            } catch {
                print(error)
            }
        }
        firestoreClient.deleteBalanceChange(uid: bubbleUser?.id ?? "", id: id)
    }
}

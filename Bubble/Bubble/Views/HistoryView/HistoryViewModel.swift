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
    
    let uid: String?
    
    init(uid: String?) {
        self.uid = uid
        
        addBalanceChangeSnapshotlistener()
    }
    
    
    func addBalanceChangeSnapshotlistener() {
        
        firestoreClient.store.collection("users")
            .document(uid ?? "")
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
                    
                }
            }
        
    }
    
    func addBalanceChange(){
        
        do {
           try firestoreClient.addBalanceChange(uid: uid ?? "",
                                             name: balanceChangeName,
                                             amount: balanceChangeAmount,
                                             type: balanceChangeType.rawValue,
                                             currentBalance: balanceChangeCurrentBalance,
                                             date: balanceChangeDate)
        } catch {
            print(error)
        }
    }
    
    func deleteBalanceChange(id: String) {
        firestoreClient.deleteBalanceChange(uid: uid ?? "", id: id)
    }
}

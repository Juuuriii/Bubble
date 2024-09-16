//
//  HistoryViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 16.09.24.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
    @Published var history = [BalanceChange]()
    
    @Published var balanceChangeName = ""
    @Published var balanceChangeAmount = 1.0
    @Published var balanceChangeType: BalanceChangeType = .expense
    @Published var balanceChangeCurrentBalance = 0.0
    @Published var balanceChangeDate = Date.now
    
    let uid: String?
    
    init(uid: String?) {
        self.uid = uid
    }
    
    func getBalanceChages(){
        Task{
            do {
               history = try await firestoreClient.getBalanceChanges(uid: uid ?? "")
            } catch {
                print(error)
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

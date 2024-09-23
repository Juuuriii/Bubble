//
//  FirestoreClient.swift
//  Bubble
//
//  Created by Juri Huhn on 21.08.24.
//

import Foundation
import FirebaseFirestore

class FirestoreClient {
    
    static let shared = FirestoreClient()
    let store = Firestore.firestore()
    
    func createUser(uid: String, email: String, username: String) throws {
        let user = BubbleUser(id: uid, email: email, username: username, currency: Locale.current.currencySymbol ?? "€")
        
        try store.collection("users")
            .document(uid)
            .setData(from: user)
    }
    
    func getUser(uid: String) async -> BubbleUser? {
        
        return try? await store
            .collection("users")
            .document(uid)
            .getDocument()
            .data(as: BubbleUser.self)
        
    }
    
    func createSavingGoal(
        id: String,
        uid: String,
        name: String,
        type: String,
        targetDate: Date,
        repeats: String,
        targetAmount: Double,
        savedAmount: Double) throws {
            
            let savingGoal = SavingGoal(id: id, name: name, type: type, targetDate: targetDate, repeats: repeats, targetAmount: targetAmount, savedAmount: savedAmount, finished: false, uid: uid)
            
            try store.collection("users")
                .document(uid)
                .collection("wallet")
                .document(savingGoal.id)
                .setData(from: savingGoal)
        }
    
    
    
    func deleteSavingGoal(uid: String ,id: String)  {
        
        store.collection("users")
            .document(uid)
            .collection("wallet")
            .document(id)
            .delete()
        
    }
    
    func updateAmountSaved(uid: String ,id: String, newAmount: Double) async throws {
        
        try await store.collection("users")
            .document(uid)
            .collection("wallet")
            .document(id)
            .updateData([
                "savedAmount" : newAmount
            ])
        
    }
    
    func updateUserBalance(uid: String, oldAmount: Double?, amount: Double, type: BalanceChangeType, delete: Bool = false) async throws {
        
        guard let balance = oldAmount else {
            return
        }
        
        var newAmount = 0.0
        
        switch type {
        case .income:
            if delete {
                newAmount = balance - amount
            } else {
                newAmount = balance + amount
            }
        case .expense:
            if delete {
                newAmount = balance + amount
            } else {
                newAmount = balance - amount
            }
        }
        
        try await store.collection("users")
            .document(uid)
            .updateData([
                "balance" : newAmount
            ])
        
    }
    
    func updateBalance(uid: String, newAmount: Double) async throws {
        
        try await store.collection("users")
            .document(uid)
            .updateData([
                "balance" : newAmount
            ])
        
    }
    
    
    
    
    
    func deleteBalanceChange(uid: String, id: String) {
        
        store.collection("users")
            .document(uid)
            .collection("history")
            .document(id)
            .delete()
    }
    
    
    func _addBalanceChange(balanceChange: BalanceChange) throws  {
        
        try  store.collection("users")
            .document(balanceChange.uid)
            .collection("history")
            .document(balanceChange.id)
            .setData(from: balanceChange)
    }
    
    func _addBalanceChange(balanceChange: BalanceChange, from savingGoalID: String) throws {
        
        try store.collection("users")
            .document(balanceChange.uid)
            .collection("wallet")
            .document(savingGoalID)
            .collection("history")
            .document(balanceChange.id)
            .setData(from: balanceChange)
        
    }
    
    func addSavingGoal(savingGoal: SavingGoal) throws {
      try store.collection("users")
            .document(savingGoal.uid)
            .collection("wallet")
            .document(savingGoal.id)
            .setData(from: savingGoal)
    }
    
    func deleteBalanceChange(uid: String, sgID: String, bcID: String) {
        
        store.collection("users")
            .document(uid)
            .collection("wallet")
            .document(sgID)
            .collection("history")
            .document(bcID)
            .delete()
    }
    
}

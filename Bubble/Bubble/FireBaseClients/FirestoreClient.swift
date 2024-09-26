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
    
    private var userListener: ListenerRegistration?
   
    func addUserListener(uid: String?, update: @escaping (BubbleUser) -> Void) {
        
        guard let uid = uid else {
            return
        }
        
        userListener = store.collection("users")
            .document(uid)
            .addSnapshotListener { snapShot, error in
                if let error = error {
                    print(error)
                          return
                }
                
                if let user = try? snapShot?.data(as: BubbleUser.self) {
                    update(user)
                }
            }
    }
    
    func createUser(uid: String, email: String, username: String) throws {
        let user = BubbleUser(id: uid, email: email, username: username, currency: Locale.current.currencySymbol ?? "€", quickAddAmount: QuickAddAmount.ten.rawValue)
        
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
    
    func updateAmountSaved(uid: String ,id: String, newAmount: Double, isFinished: Bool) async throws {
        
        try await store.collection("users")
            .document(uid)
            .collection("wallet")
            .document(id)
            .updateData([
                "savedAmount" : newAmount,
                "finished" : isFinished
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
    
    func updateCurrency(uid: String, currency: String) async throws {
        
        try await store.collection("users")
            .document(uid)
            .updateData([
                "currency" : currency
            ])
        
        
    }
    
    func updateQuickAddAmount(uid: String, amount: Double) async throws {
        try await store.collection("users")
            .document(uid)
            .updateData([
                "quickAddAmount" : amount
            ])
    }
    
    func updateEmail(uid: String, newEmail: String) async throws {
        try await store.collection("users")
            .document(uid)
            .updateData([
                "email" : newEmail
            ])
    }
    
    func updateAmountOfGoals(uid: String, newAmount: Int) async throws {
        try await store.collection("users")
            .document(uid)
            .updateData([
                "savingGoalsAmount" : newAmount
            ])
    }
    
   func updateAmountOfFinishedGoals(uid: String, newAmount: Int) async throws {
        try await store.collection("users")
            .document(uid)
            .updateData([
                "finishedSavingGoals" : newAmount
            ])
    }
    
    
    
}

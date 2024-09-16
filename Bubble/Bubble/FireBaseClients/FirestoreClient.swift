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
        let user = BubbleUser(id: uid, email: email, username: username)
        
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
        uid: String,
        name: String,
        type: String,
        targetDate: Date,
        repeats: String,
        targetAmount: Double,
        savedAmount: Double) throws {
            
            let savingGoal = SavingGoal(name: name, type: type, targetDate: targetDate, repeats: repeats, targetAmount: targetAmount, savedAmount: savedAmount, finished: false, uid: uid)
            
            try store.collection("users")
                .document(uid)
                .collection("wallet")
                .document(savingGoal.id.uuidString)
                .setData(from: savingGoal)
        }
    
    func getSavingGoals(uid: String) async throws -> [SavingGoal] {
        
        let filters: [Filter] = [Filter.whereField("uid", isEqualTo: uid)]
        
        let query = store.collectionGroup("wallet").whereFilter(Filter.andFilter(filters))
        
        let result = try await query.getDocuments().documents.map {try $0.data(as: SavingGoal.self)}
        
        return result
        
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
    
    func addBalanceChange(uid: String, name: String, amount: Double, type: String, currentBalance: Double, date: Date) throws  {
        
        let balanceChange = BalanceChange(uid: uid, name: name, amount: amount, type: type, currentBalance: currentBalance, date: date)
        
        try  store.collection("users")
            .document(uid)
            .collection("history")
            .document(balanceChange.id)
            .setData(from: balanceChange)
    }
    
    func getBalanceChanges(uid: String) async throws -> [BalanceChange]{
        
        let filters: [Filter] = [Filter.whereField("uid", isEqualTo: uid)]
        
        let query = store.collectionGroup("history").whereFilter(Filter.andFilter(filters))
        
        let result = try await query.getDocuments().documents.map {try $0.data(as: BalanceChange.self)}
        
        return result
    }
    
    func deleteBalanceChange(uid: String, id: String) {
        
        store.collection("users")
            .document(uid)
            .collection("history")
            .document(id)
            .delete()
    }
    
    
    
}

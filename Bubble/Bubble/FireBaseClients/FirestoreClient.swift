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
    private let store = Firestore.firestore()
    
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
    
    
    
}

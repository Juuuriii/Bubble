//
//  AuthViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 21.08.24.
//

import Foundation
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    
    @Published var user: FirebaseAuth.User? = nil
    
    @Published var showMainView = false
    
    init() {
        user = authClient.checkAuth()
        showMainView = user != nil
    }
    
    func register() {
        Task {
            do {
                user = try await authClient.register(email: email, password: password)
                guard let user else { return }
                try firestoreClient.createUser(uid: user.uid, email: email, username: username)
            } catch {
                print(error)
            }
        }
    }
    
    func login() {
        Task {
            do {
                user = try await authClient.login(email: email, password: password)
                guard let user else { return }
                if await firestoreClient.getUser(uid: user.uid) == nil {
                    try firestoreClient.createUser(uid: user.uid, email: email, username: username)
                }
                showMainView = true
            } catch {
                print(error)
            }
        }
    }
    
    func logout() {
        do {
            try authClient.logout()
            user = authClient.checkAuth()
            showMainView = false
        } catch {
            print(error)
        }
    }
    
    func deleteUser() {
        Task {
            do{
                try await authClient.deleteUser()
            } catch {
                print(error)
            }
        }
    }
    
    func addUserSnapshotListener() {
        
        
        
    }
    
}

//
//  AuthClient.swift
//  Bubble
//
//  Created by Juri Huhn on 21.08.24.
//

import Foundation
import FirebaseAuth

class AuthClient {
    
    static let shared = AuthClient()
    private let auth = Auth.auth()
    
    
    
    func checkAuth() -> FirebaseAuth.User? {
        return auth.currentUser
    }
    
    
    
    func register(email: String, password: String) async throws -> FirebaseAuth.User {
        
        let result = try await auth.createUser(withEmail: email, password: password)
        return result.user
        
    }
    
    func login(email: String, password: String) async throws -> FirebaseAuth.User {
        
        let result = try await auth.signIn(withEmail: email, password: password)
        return result.user
    }
    
    func logout() throws {
        try auth.signOut()
    }
    
    func deleteUser(password: String) async throws {
        guard let user = auth.currentUser else {
            return
        }
        guard let email = user.email else {
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        user.reauthenticate(with: credential) { result, error in
            if let error = error {
                print(error)
            } else {
                result?.user.delete()
            }
        }
    }
    
    func sendResetPasswordMail(){
        
        if let user = auth.currentUser {
            
            auth.sendPasswordReset(withEmail: user.email!)
            
        }
    }
    
    func changeEmail(password: String, newEmail: String) {
        
        guard let user = auth.currentUser else {
            return
        }
        
        guard let email = auth.currentUser?.email else {
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        user.reauthenticate(with: credential) { authResult, error in
            
            if let error = error {
                print(error as Any)
            } else {
                authResult?.user.sendEmailVerification(beforeUpdatingEmail: newEmail)
                
            }
        }
        
    }
}

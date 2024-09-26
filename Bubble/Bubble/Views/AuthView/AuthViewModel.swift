//
//  AuthViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 21.08.24.
//

import Foundation
import FirebaseAuth

enum AuthScreen {
    case login, signup
}

@MainActor
class AuthViewModel: ObservableObject {
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
    
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    
    @Published var user: FirebaseAuth.User? = nil
    
    @Published var showMainView = false
    @Published var showResetPasswordAlert = false
    @Published var showChangeEmailSheet = false
    @Published var showDeleteUserAlert = false
    @Published var showLogoutAlert = false
    
    @Published var screen: AuthScreen = .login
    
    @Published var errorMessage = ""
    @Published var showErrorAlert = false
    
    init() {
        user = authClient.checkAuth()
        showMainView =  user != nil
    }
    
    func register() {
        Task {
            do {
                user = try await authClient.register(email: email, password: password)
                guard let user else { return }
                try firestoreClient.createUser(uid: user.uid, email: email, username: username)
                showMainView  = true
                resetTextFields()
            } catch {
                handleError(error as NSError)
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
                if await firestoreClient.getUser(uid: user.uid)?.email != authClient.checkAuth()?.email {
                    
                    if let newEmail = authClient.checkAuth()?.email {
                        
                        try await firestoreClient.updateEmail(uid: user.uid, newEmail: newEmail)
                    }
                }
                showMainView = true
                resetTextFields()
            } catch {
                handleError(error as NSError) 
            }
        }
    }
    
    func logout() {
        do {
            try authClient.logout()
            user = authClient.checkAuth()
            firestoreClient.removeListener()
            showMainView = false
        } catch {
            handleError(error as NSError)
        }
    }
    
    func deleteUser() {
        Task {
            do {
                try await authClient.deleteUser(password: password)
                logout()
            } catch {
                handleError(error as NSError)
            }
        }
    }
    
    func changeEmail() {
        Task {
            do {
                try await authClient.changeEmail(password: password, newEmail: email)
                logout()
            } catch {
                handleError(error as NSError)
            }
        }
    }
    
    func sendResetPasswordEmail() {
        authClient.sendResetPasswordMail()
    }
    
    func resetTextFields() {
        email = ""
        password = ""
        username = ""
    }
    
    private func handleError(_ error: NSError) {
        print(error.localizedDescription)
        let errorCode = AuthErrorCode(rawValue: error.code)
        
        switch errorCode {
        case .userNotFound:
            errorMessage = "User not found"
        case .invalidCredential:
            errorMessage = "Wrong Password or Email"
        case .userDisabled:
            errorMessage = "User was deactivated"
        case .emailAlreadyInUse, .accountExistsWithDifferentCredential, .credentialAlreadyInUse:
            errorMessage = "There already is an Account with this Email"
        case .networkError:
            errorMessage = "Network Issue"
        case .weakPassword:
            errorMessage = "Password too weak"
        case .rejectedCredential:
            errorMessage = "Invalid Credentials"
        
        default:
            errorMessage = "Unkown Error"
        }
        
        showErrorAlert = true
    }
    
}

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
    
    @Published var showSettingsViewError = false
    
    
    @Published var showResetPasswordAlert = false
    @Published var showLogoutAlert = false
    
    @Published var showChangeEmailSheet = false
    @Published var showDeleteUserSheet = false
    
    
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
                handleError(error as NSError, isAuthView: true)
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
                handleError(error as NSError, isAuthView: true)
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
            handleError(error as NSError, isAuthView: false)
        }
    }
    
    func deleteUser() {
        Task {
            do {
                showDeleteUserSheet = false
                try await authClient.deleteUser(password: password)
               
                logout()
            } catch {
               
               handleError(error as NSError, isAuthView: false)
            }
        }
    }
    
    func changeEmail() {
        Task {
            do {
                try await authClient.changeEmail(password: password, newEmail: email)
                logout()
            } catch {
                handleError(error as NSError, isAuthView: false)
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
    
    private func handleError(_ error: NSError, isAuthView: Bool) {
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
        case .tooManyRequests:
            errorMessage = "Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later."
        
        default:
            errorMessage = "Unkown Error"
        }
        if isAuthView {
            showErrorAlert = true
        } else {
            showSettingsViewError = true
        }
    }
    
}

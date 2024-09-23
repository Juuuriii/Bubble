//
//  SettingsViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 19.09.24.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
    @Published var showResetPasswordAlert = false
    
    @Published var password = ""
    @Published var newEmail = ""
    @Published var showChangeEmailSheet = false
    
    func sendResetPasswordEmail() {
        authClient.sendResetPasswordMail()
    }
    
    func changeEmail(){
        
        authClient.changeEmail(password: password, newEmail: newEmail)
        
    }
}

//
//  DeleteUserSheet.swift
//  Bubble
//
//  Created by Juri Huhn on 24.09.24.
//

import SwiftUI

struct DeleteUserSheet: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack{
            Text("Delete Account")
                .font(.title2)
                .padding()
            
            Text("Verify Password before deleting Account")
            SecureField("Password", text: $authViewModel.deletePassword)
                .textFieldStyle(.roundedBorder)
            
            Button("Delete", role: .destructive){
                authViewModel.deleteUser()
                authViewModel.logout()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .disabled(authViewModel.deletePassword.isEmpty)
        }
        .padding()
    }
}

#Preview {
    DeleteUserSheet(authViewModel: AuthViewModel())
}

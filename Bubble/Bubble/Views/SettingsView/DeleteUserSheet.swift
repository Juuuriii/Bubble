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
            SecureField("Password", text: $authViewModel.password)
                .textFieldStyle(.roundedBorder)
            
            Button("Delete", role: .destructive){
                authViewModel.deleteUser()
                authViewModel.showDeleteUserAlert = false
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .disabled(authViewModel.password.isEmpty)
        }
        .padding()
        .onDisappear{
            authViewModel.resetTextFields()
        }
    }
}

#Preview {
    DeleteUserSheet(authViewModel: AuthViewModel())
}

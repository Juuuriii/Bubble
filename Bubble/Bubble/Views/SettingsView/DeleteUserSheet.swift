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
            VStack{
                Text("Delete Account")
                    .foregroundStyle(BubbleColors.darkBlue)
                    .font(.title2)
                    .padding()
                
                Text("Verify Password before deleting Account")
                    .foregroundStyle(BubbleColors.darkBlue)
                
                SecureField("Password", text: $authViewModel.password)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(BubbleColors.white)
                    }
                    .padding(.bottom, 24)
                
                Button("Delete", role: .destructive){
                    authViewModel.deleteUser()
                    authViewModel.showDeleteUserAlert = false
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(authViewModel.password.isEmpty)
                
            }
            .padding()
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(BubbleColors.lightBlue)
                    .shadow(radius: 10)
                    .padding()
            }
            .onDisappear{
                authViewModel.resetTextFields()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BubbleColors.midBlue)
    }
}

#Preview {
    DeleteUserSheet(authViewModel: AuthViewModel())
}

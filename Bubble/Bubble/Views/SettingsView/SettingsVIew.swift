//
//  SettingsVIew.swift
//  Bubble
//
//  Created by Juri Huhn on 19.09.24.
//

import SwiftUI

struct SettingsVIew: View {
    
    @StateObject var viewModel = SettingsViewModel()
    @ObservedObject var authViewModel: AuthViewModel
   
    
    var body: some View {
        ScrollView {
            
            VStack{
            }
            .frame(height: 32)
            
            SettingsViewItem(viewModel: authViewModel)
                .padding(.bottom, 48)
            
            SettingsViewItem2(viewModel: viewModel)
                .padding(.bottom, 48)
            
            SettingsViewItem3(viewModel: authViewModel)
                .padding(.bottom, 48)
        }
        .background(BubbleColors.bgBlue)
        .alert("Reset Password", isPresented: $authViewModel.showResetPasswordAlert){
            Button("Ok"){
                
            }
        } message: {
            Text("We send you an Email to reset your Password.")
        }
        .alert("You are about to Log out", isPresented: $authViewModel.showLogoutAlert) {
            Button("Log Out", role: .destructive) {
                authViewModel.logout()
            }
            Button("Cancel", role: .cancel) {
                
            }
        }
        .alert(authViewModel.errorMessage, isPresented: $authViewModel.showSettingsViewError) {
            Button("Dismiss") {
                
            }
        }
        .sheet(isPresented: $authViewModel.showDeleteUserSheet , content: {
            DeleteUserSheet(authViewModel: authViewModel)
                .presentationDetents([.height(340), .medium])
        })
        .sheet(isPresented: $authViewModel.showChangeEmailSheet, content: {
           ChangeEmailSheet(viewModel: authViewModel)
                .presentationDetents([.medium, .large])
        })
        
    }
}

#Preview {
    SettingsVIew(authViewModel: AuthViewModel())
}


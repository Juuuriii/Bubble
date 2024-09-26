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
        .alert(isPresented: $authViewModel.showResetPasswordAlert){
            Alert(title: Text("Reset Password"), message: Text("We send you an Email to reset your Password."), dismissButton: .default(Text("Ok")))
        }
        .sheet(isPresented: $authViewModel.showChangeEmailSheet, content: {
            List{
                TextField("New Email", text: $authViewModel.email)
                SecureField("Password", text: $authViewModel.password)
                Button{
                    
                    authViewModel.changeEmail()
                    
                    authViewModel.showChangeEmailSheet = false
                    
                } label: {
                    Text("Change Email")
                }
                .buttonStyle(.borderedProminent)
            }
            .onDisappear{
                authViewModel.resetTextFields()
            }
        })
    }
}

#Preview {
    SettingsVIew(authViewModel: AuthViewModel())
}

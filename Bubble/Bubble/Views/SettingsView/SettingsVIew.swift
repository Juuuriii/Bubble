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
            
            SettingsViewItem(viewModel: viewModel)
                .padding(.bottom, 48)
            
            SettingsViewItem2(viewModel: viewModel)
                .padding(.bottom, 48)
            
            SettingsViewItem3(viewModel: viewModel, authViewModel: authViewModel)
                .padding(.bottom, 48)
        }
        .background(Color(hex: "A4D8F5"))
        .alert(isPresented: $viewModel.showResetPasswordAlert){
            Alert(title: Text("Reset Password"), message: Text("We send you an Email to reset your Password."), dismissButton: .default(Text("Ok")))
        }
        .sheet(isPresented: $viewModel.showChangeEmailSheet, content: {
            List{
                TextField("New Email", text: $viewModel.newEmail)
                SecureField("Password", text: $viewModel.password)
                Button{
                    
                    viewModel.changeEmail()
                    
                    viewModel.showChangeEmailSheet = false
                    
                } label: {
                    Text("Change Email")
                }
                .buttonStyle(.borderedProminent)
            }
        })
    }
}

#Preview {
    SettingsVIew(authViewModel: AuthViewModel())
}

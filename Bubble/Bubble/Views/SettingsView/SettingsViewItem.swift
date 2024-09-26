//
//  SettingsViewItem.swift
//  Bubble
//
//  Created by Juri Huhn on 19.09.24.
//

import SwiftUI

struct SettingsViewItem: View {
    
    @ObservedObject var viewModel: AuthViewModel
    
    @State private var size: CGSize = .zero
    
    var body: some View {
        VStack{
            VStack{
                CapsuleHeader(title: "Account settings", description: "Your Personal Details", offsetPercent: 0.5)
                
                VStack(spacing: 16) {
                    Button{
                        viewModel.sendResetPasswordEmail()
                        viewModel.showResetPasswordAlert = true
                    } label: {
                        Text("Reset Password")
                        
                            .foregroundStyle(.white)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .padding()
                            .background{
                                Capsule()
                                    .foregroundStyle(BubbleColors.darkBlue)
                            }
                        
                    }
                    Button{
                        viewModel.showChangeEmailSheet = true
                    } label: {
                        Text("Change Email Adress")
                        
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background{
                                Capsule()
                                    .foregroundStyle(BubbleColors.darkBlue)
                            }
                    }
                }
                .offset(y: -12)
                .padding(.horizontal)
            }
            .padding(.bottom, 32)
            .background{
                SettingsBackground()
                    .foregroundStyle(BubbleColors.midBlue)
                
            }
            .alert(viewModel.errorMessage,
                   isPresented: $viewModel.showErrorAlert) {
                Button("Dismiss", role: .cancel) {
                    
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    SettingsViewItem(viewModel: AuthViewModel())
}

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
                HStack{
                    VStack{
                        Text("ACCOUNT SETTINGS")
                            .foregroundStyle(BubbleColors.darkBlue)
                            .font(.title2)
                            .frame(minWidth: 220)
                        Text("Your Personal Details")
                            .foregroundStyle(BubbleColors.darkBlue)
                            .font(.footnote)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(
                        GeometryReader{proxy in
                            Capsule()
                                .foregroundStyle(BubbleColors.lightBlue)
                                .onAppear{
                                    size = proxy.size
                                }
                        }
                    )
                    Spacer()
                }
                .offset(y: -size.height*0.5)
                
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
                .offset(y: -size.height*0.2)
                .padding(.horizontal)
            }
            .padding(.bottom, 32)
            .background{
                SettingsBackground()
                    .foregroundStyle(BubbleColors.midBlue)
                
            }
               
                
            
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    SettingsViewItem(viewModel: AuthViewModel())
}

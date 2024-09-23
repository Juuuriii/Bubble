//
//  SettingsViewItem.swift
//  Bubble
//
//  Created by Juri Huhn on 19.09.24.
//

import SwiftUI

struct SettingsViewItem: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    @State private var size: CGSize = .zero
    
    var body: some View {
        VStack{
                Image("SettingsRect1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay{
                        VStack{
                            HStack{
                                VStack{
                                    Text("ACCOUNT SETTINGS")
                                        .font(.title2)
                                        .frame(minWidth: 220)
                                    Text("Your Personal Details")
                                        .font(.footnote)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(
                                    GeometryReader{proxy in
                                        Capsule()
                                            .foregroundStyle(Color(hex: "84C6EB"))
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
                                                .foregroundStyle(Color(hex: "14135B"))
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
                                                .foregroundStyle(Color(hex: "14135B"))
                                        }
                                    
                                }
                            }
                            .offset(y: -size.height*0.2)
                            .padding(.horizontal)
                            Spacer()
                        }
                    }
               
                
            
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    SettingsViewItem(viewModel: SettingsViewModel())
}

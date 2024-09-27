//
//  SettingsViewItem3.swift
//  Bubble
//
//  Created by Juri Huhn on 19.09.24.
//

import SwiftUI

struct SettingsViewItem3: View {
    @State private var size: CGSize = .zero
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            VStack{
                CapsuleHeader(title: "Log out", description: "Log out or Delete your Account", offsetPercent: 0.5)
                
                VStack(spacing: 16) {
                    Button{
                        viewModel.showDeleteUserSheet = true
                    } label: {
                        Text("Delete Account")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background{
                                Capsule()
                                    .foregroundStyle(BubbleColors.darkBlue)
                            }
                        
                    }
                    Button{
                        viewModel.showLogoutAlert = true
                    } label: {
                        Text("Log out")
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
                .padding(.bottom, 32)
            }
            .background{
                AchievementBackgroundShape()
                    .foregroundStyle(BubbleColors.midBlue)
            }
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    SettingsViewItem3(viewModel: AuthViewModel())
}

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
                HStack{
                    VStack{
                        Text("LOG OUT & DELETE")
                            .font(.title2)
                            .frame(minWidth: 220)
                        Text("I hope I'll see you soon again :)")
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
                        viewModel.showDeleteUserAlert = true
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
                .offset(y: -size.height*0.2)
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .background{
                AchievementBackgroundShape()
                    .foregroundStyle(BubbleColors.midBlue)
            }
        }
        .padding(.horizontal)
        .alert("You are about to Log out", isPresented: $viewModel.showLogoutAlert) {
            Button("Log Out", role: .destructive) {
                viewModel.logout()
            }
            Button("Cancel", role: .cancel) {
                
            }
        }
        .sheet(isPresented: $viewModel.showDeleteUserAlert , content: {
            DeleteUserSheet(authViewModel: viewModel)
                .presentationDetents([.height(340), .medium])
        })
    }
}

#Preview {
    SettingsViewItem3(viewModel: AuthViewModel())
}

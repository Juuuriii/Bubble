//
//  AuthView.swift
//  Bubble
//
//  Created by Juri Huhn on 23.08.24.
//

import SwiftUI


struct AuthView: View {
    
    @StateObject var viewModel = AuthViewModel()
    
    @Namespace var key
    
    
    
    var body: some View {
        
        GeometryReader { proxy in
            
            
            VStack{
                
                Spacer()
                
                Image("logo")
                    .padding(.bottom, 40)
                
                
                VStack(spacing: -16) {
                    AuthViewTabs(viewModel: viewModel)
                    
                    VStack{
                        TabView(selection: $viewModel.screen) {
                            VStack(){
                                Spacer()
                                VStack{
                                    TextField("Email", text: $viewModel.email)
                                        .bubbleTextFieldStyle()
                                    
                                    SecureField("Password", text: $viewModel.password)
                                        .bubbleTextFieldStyle()
                                }
                                Spacer()
                                Button("Login"){
                                    viewModel.login()
                                }
                                .authButtonStyle()
                                
                                .padding(.bottom, 40)
                            }
                            .tag(AuthScreen.login)
                            
                            VStack(){
                                Spacer()
                                VStack {
                                    TextField("Username", text: $viewModel.username)
                                        .bubbleTextFieldStyle()
                                    TextField("Email", text: $viewModel.email)
                                        .bubbleTextFieldStyle()
                                    SecureField("Password", text: $viewModel.password)
                                        .bubbleTextFieldStyle()
                                    
                                }
                                Spacer()
                                Button("Sign up"){
                                    viewModel.register()
                                }
                                .authButtonStyle()
                                
                                .padding(.bottom, 40)
                            }
                            .tag(AuthScreen.signup)
                            
                        }
                        
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .padding()
                        .frame(height: proxy.size.height*0.45)
                    }
                }
                .padding(.top)
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.white)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BubbleColors.lightBlue)
            .fullScreenCover(isPresented: $viewModel.showMainView, content: {
                MainView(authViewModel: viewModel)
            })
            .alert(viewModel.errorMessage,
                   isPresented: $viewModel.showErrorAlert) {
                Button("Dismiss") {
                    
                }
            }
            
        }
    }
}


#Preview {
    AuthView()
}

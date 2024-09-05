//
//  AuthView.swift
//  Bubble
//
//  Created by Juri Huhn on 23.08.24.
//

import SwiftUI


struct AuthView: View {
    
    @ObservedObject var viewModel: AuthViewModel
   
    @State var scrollPosition = 0
    let colors: [Color] = [.red, .green, .blue]
    
    var body: some View {
        
        
            
                
        GeometryReader { proxy in
            VStack{
                Image("logo")
            }
            VStack{
                Spacer()
                HStack{
                    Button("Sign in"){
                        
                        scrollPosition = 0
                        
                    }
                    .padding(.vertical)
                    Spacer()
                        .frame(width: 120)
                    Button("Sign up"){
                        
                        scrollPosition = 1
                        
                    }
                    .padding(.vertical)
                }
                ScrollViewReader { value in
                    
                    
                    ScrollView(.horizontal){
                        
                        LazyHStack{
                            VStack(spacing: 24){
                                TextField("Email", text: $viewModel.email)
                                    .bubbleTextFieldStyle()
                                
                                SecureField("Password", text: $viewModel.password)
                                    .bubbleTextFieldStyle()
                                
                                Button("Sign in") {
                                    viewModel.login()
                                }
                                .authButtonStyle()
                            }
                            .id(0)
                            .frame(width: proxy.size.width)
                            
                            
                            VStack(spacing: 24){
                                TextField("Username", text: $viewModel.username)
                                    .bubbleTextFieldStyle()
                                
                                TextField("Email", text: $viewModel.email)
                                    .bubbleTextFieldStyle()
                                
                                SecureField("Password", text: $viewModel.password)
                                    .bubbleTextFieldStyle()
                                
                                Button("Sign up") {
                                    viewModel.register()
                                }
                                .authButtonStyle()
                            }
                            .id(1)
                            .frame(width: proxy.size.width)
                            
                        }
                        .scrollTargetLayout()
                        
                    }
                    .background(.orange)
                    .scrollTargetBehavior(.viewAligned)
                    .onChange(of: scrollPosition) {
                        withAnimation{
                            value.scrollTo(scrollPosition, anchor: .center)
                        }
                    }
                    .scrollDisabled(true)
                }
            }
            .background{
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.white)
            }
        }
        .background(.blue.opacity(0.2))
    }
}


#Preview {
    AuthView(viewModel: AuthViewModel())
}

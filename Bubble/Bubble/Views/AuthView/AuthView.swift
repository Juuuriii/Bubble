//
//  AuthView.swift
//  Bubble
//
//  Created by Juri Huhn on 23.08.24.
//

import SwiftUI


struct AuthView: View {
    
    @StateObject var viewModel = AuthViewModel()
   
    @State var scrollPosition = 0
    let colors: [Color] = [.red, .green, .blue]
    
    var body: some View {
        
        
            VStack(spacing: 64){
                Spacer()
                Image("logo")
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(.white)
                  //  .frame(width: 0.9*proxy.size.width, height: 0.4*proxy.size.height)
                    .overlay{
                        GeometryReader { proxy in
                            VStack{
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
                                                    
                                                }
                                                .authButtonStyle()
                                                
                                            }
                                            .id(0)
                                            .frame(width: proxy.size.width)
                                            
                                            VStack(spacing: 24){
                                                TextField("Email", text: $viewModel.email)
                                                    .bubbleTextFieldStyle()
                                                
                                                SecureField("Password", text: $viewModel.password)
                                                    .bubbleTextFieldStyle()
                                                
                                                
                                                Button("Sign up") {
                                                }
                                                .authButtonStyle()
                                            }
                                            .id(1)
                                            .frame(width: proxy.size.width)
                                            
                                        }
                                        
                                        .scrollTargetLayout()
                                    }
                                    .scrollTargetBehavior(.viewAligned)
                                    .onChange(of: scrollPosition) {
                                        withAnimation{
                                            value.scrollTo(scrollPosition, anchor: .center)
                                        }
                                    }
                                    .scrollDisabled(true)
                                    
                                }
                                
                                
                            }
                        }
                    }
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue.opacity(0.2))
    }
    
}


#Preview {
    AuthView()
}

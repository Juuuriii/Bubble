//
//  AuthView.swift
//  Bubble
//
//  Created by Juri Huhn on 23.08.24.
//

import SwiftUI


struct AuthView: View {
    
    @StateObject var viewModel = AuthViewModel()
   
    @State var selectedTab = 1
    
    var body: some View {
        
        GeometryReader{ proxy in
            VStack(spacing: 64){
                Spacer()
                Image("logo")
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(.white)
                    .frame(width: 0.9*proxy.size.width, height: 0.4*proxy.size.height)
                    .overlay{
                        VStack(spacing: 32){
                            HStack{
                                Button("Sign in"){
                                    withAnimation{
                                        selectedTab = 1
                                    }
                                }
                                Spacer()
                                    .frame(width: 120)
                                Button("Sign up"){
                                    withAnimation{
                                        selectedTab = 2
                                    }
                                }
                            }
                            TabView(selection: $selectedTab){
                                VStack{
                                    TextField("Email", text: $viewModel.email)
                                        .bubbleTextFieldStyle()
                            
                                    SecureField("Password", text: $viewModel.password)
                                        .bubbleTextFieldStyle()
                                
                                    Button("Sign in") {
                                        
                                    }
                                    .authButtonStyle()
                                    
                                }
                                .tag(1)
                              
                                
                                VStack{
                                    TextField("Email", text: $viewModel.email)
                                        .bubbleTextFieldStyle()
                            
                                    SecureField("Password", text: $viewModel.password)
                                        .bubbleTextFieldStyle()
                                    

                                    Button("Sign up") {
                                    }
                                    .authButtonStyle()
                                }
                                .tag(2)
                                
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue.opacity(0.2))
            
        }
    }
    
}


#Preview {
    AuthView()
}

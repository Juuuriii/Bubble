//
//  AuthView.swift
//  Bubble
//
//  Created by Juri Huhn on 23.08.24.
//

import SwiftUI


struct AuthView: View {
    
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        VStack{
            Image("logo")
            
            ZStack{
                
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                VStack{
                    HStack{
                        Button("Sign in"){
                            
                        }
                        .foregroundStyle(.blue)
                        
                        Button("Sign up"){
                            
                        }
                        .foregroundStyle(.blue)
                    }
                    
                    ScrollView(.horizontal) {
                        VStack() {
                            TextField("Email", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                            
                            SecureField("Password", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                            
                            Button{
                                
                            } label: {
                                Text("Sign in")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .frame(maxWidth: .infinity)
                        .background(.orange)
                    }
                    .background(.red)
                    
                }
            }
            .padding()
            .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.2))
    }
}

#Preview {
    AuthView()
}

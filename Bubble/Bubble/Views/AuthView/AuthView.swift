//
//  AuthView.swift
//  Bubble
//
//  Created by Juri Huhn on 23.08.24.
//

import SwiftUI


struct AuthView: View {
    
    @StateObject var viewModel = AuthViewModel()
    @State var text = ""
    
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
                                        
                                    }
                                    Spacer()
                                        .frame(width: 120)
                                    Button("Sign up"){
                                        
                                    }
                                }
                                
                                    ZStack{
                                        Capsule()
                                            .foregroundStyle(Color(hex: "#CFE0EA"))
                                            .frame(height: 48)

                                        TextField("Email", text: $text)
                                            .padding()
                                    }
                                    .padding(.horizontal)
                                    
                                    ZStack{
                                        Capsule()
                                            .foregroundStyle(Color(hex: "#CFE0EA"))
                                            .frame(height: 48)

                                        SecureField("Password", text: $text)
                                            .padding()
                                    }
                                    .padding(.horizontal)
                                    
                                    Button("Sign in") {
                                        
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .buttonBorderShape(.capsule)
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

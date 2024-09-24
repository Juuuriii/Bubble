//
//  AuthViewTabs.swift
//  Bubble
//
//  Created by Juri Huhn on 24.09.24.
//

import SwiftUI



struct AuthViewTabs: View {
    
    @ObservedObject var viewModel: AuthViewModel
    
    @State private var side = true
    @State private var colorSaving = Color.white
    @State private var colorHistory = Color(hex: "14135B")
    
    
    @Namespace var key
    
    var body: some View {
        HStack{
            Button {
                withAnimation{
                    viewModel.screen = .login
                }
            } label: {
                Text("Log in")
                    .foregroundStyle(colorSaving)
                
            }
            .padding(.horizontal, 24)
            .padding(.vertical)
            .background{
                if side {
                    Capsule()
                        .matchedGeometryEffect(id: "tab", in: key)
                        .foregroundStyle(Color(hex: "14135B"))
                }
            }
            
            Spacer()
                .frame(width: 48)
            Button {
                withAnimation{
                    viewModel.screen = .signup
                }
            } label: {
                Text("Sign up")
                    .foregroundStyle(colorHistory)
            }
            .padding(.horizontal, 24)
            .padding(.vertical)
            .background{
                if !side {
                    Capsule()
                        .matchedGeometryEffect(id: "tab", in: key)
                        .foregroundStyle(Color(hex: "14135B"))
                }
            }
            
        }
        .padding(.vertical)
        .padding(.horizontal, 64)
        .onChange(of: viewModel.screen){
            
                switch viewModel.screen {
                case .login:
                    withAnimation{
                        side = true
                        colorSaving = .white
                        colorHistory = Color(hex: "14135B")
                    }
                case .signup:
                    withAnimation{
                        side = false
                        colorSaving = Color(hex: "14135B")
                        colorHistory = .white
                    }
                    
                }
            }
        
        }
}

#Preview {
    AuthViewTabs(viewModel: AuthViewModel())
}

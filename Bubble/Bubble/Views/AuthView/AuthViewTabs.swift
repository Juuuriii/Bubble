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
    @State private var colorSaving = BubbleColors.white
    @State private var colorHistory = BubbleColors.darkBlue
    
    
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
                        .foregroundStyle(BubbleColors.darkBlue)
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
                        .foregroundStyle(BubbleColors.darkBlue)
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
                        colorSaving = BubbleColors.white
                        colorHistory = BubbleColors.darkBlue
                    }
                case .signup:
                    withAnimation{
                        side = false
                        colorSaving = BubbleColors.darkBlue
                        colorHistory = BubbleColors.white
                    }
                    
                }
            withAnimation{
                viewModel.resetTextFields()
            }
            }
        
        }
}

#Preview {
    AuthViewTabs(viewModel: AuthViewModel())
}

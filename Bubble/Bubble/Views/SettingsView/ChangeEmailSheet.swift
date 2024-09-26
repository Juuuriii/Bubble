//
//  ChangeEmailSheet.swift
//  Bubble
//
//  Created by Juri Huhn on 26.09.24.
//

import SwiftUI

struct ChangeEmailSheet: View {
    
    
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("Change Email Address")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(BubbleColors.darkBlue)
                    .font(.title)
                    .padding()
                
                
                Text("New Email Address")
                    .foregroundStyle(BubbleColors.darkBlue)

                TextField("Your new Email Address", text: $viewModel.email)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(BubbleColors.white)
                    }
                    .padding(.bottom, 24)
                
                Text("Verify with your Password")
                    .foregroundStyle(BubbleColors.darkBlue)

                SecureField("Password", text: $viewModel.password)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(BubbleColors.white)
                    }
                    .padding(.bottom, 24)
                HStack {
                    Button("Change Email") {
                        viewModel.changeEmail()
                        
                        viewModel.showChangeEmailSheet = false
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(BubbleColors.darkBlue)
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(BubbleColors.lightBlue)
                    .shadow(radius: 10)
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BubbleColors.midBlue)
    }
}

#Preview {
    ChangeEmailSheet(viewModel: AuthViewModel())
}

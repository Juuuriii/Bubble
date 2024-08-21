//
//  AuthView.swift
//  Bubble
//
//  Created by Juri Huhn on 21.08.24.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        VStack{
            Image("logo")
            
            ZStack{
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    
                    .foregroundStyle(.white)
                
                VStack{
                    HStack {
                        Spacer()
                        Button("Sign In") {
                            
                        }
                        .tint(Color(hex: "#14135B"))
                        Spacer()
                        Button("Sign Up") {
                            
                        }
                        .tint(Color(hex: "#14135B"))
                        Spacer()
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 24)
            
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .background(Color.blue.opacity(0.2))
    }
}

#Preview {
    AuthView()
}

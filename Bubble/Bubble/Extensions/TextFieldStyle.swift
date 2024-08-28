//
//  TextFieldStyle.swift
//  Bubble
//
//  Created by Juri Huhn on 28.08.24.
//

import SwiftUI

extension View {
    
    
    func bubbleTextFieldStyle() -> some View {
        
        ZStack{
            Capsule()
                .foregroundStyle(Color(hex: "#CFE0EA"))
                .frame(height: 48)
            
            self
                .padding()
                
        }
        .padding(.horizontal)
    }
    
}


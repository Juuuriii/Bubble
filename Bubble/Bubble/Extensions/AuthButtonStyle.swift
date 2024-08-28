//
//  AuthButtonStyle.swift
//  Bubble
//
//  Created by Juri Huhn on 28.08.24.
//

import SwiftUI

extension Button {
    
    
    func authButtonStyle() -> some View {
        
        self
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(Color(hex: "#84C6EB"))
            .foregroundStyle(Color(hex: "#14135B"))
        
    }
    
}

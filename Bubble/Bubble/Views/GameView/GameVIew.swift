//
//  GameVIew.swift
//  Bubble
//
//  Created by Juri Huhn on 27.09.24.
//

import SwiftUI

struct GameVIew: View {
    var body: some View {
        VStack{
            Image(systemName: "")
            Text("Coming Soon")
                .foregroundStyle(BubbleColors.darkBlue.opacity(0.5))
                .font(.title)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BubbleColors.bgBlue)
    }
}

#Preview {
    GameVIew()
}

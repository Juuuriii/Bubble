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
            Image("bubbleIcon")
                .resizable()
                .foregroundStyle(BubbleColors.darkBlue.opacity(0.5))
                .frame(width: 50, height: 50)
                
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

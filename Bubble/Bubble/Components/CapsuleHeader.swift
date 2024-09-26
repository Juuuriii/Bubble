//
//  CapsuleHeader.swift
//  Bubble
//
//  Created by Juri Huhn on 26.09.24.
//

import SwiftUI

struct CapsuleHeader: View {
    
    @State private var size: CGSize = .zero
    let title: String
    let description: String
    let offsetPercent: Double
    
    var body: some View {
        HStack{
            VStack{
                Text(title.uppercased())
                    .foregroundStyle(BubbleColors.darkBlue)
                    .font(.title2)
                    .frame(minWidth: 220)
                Text(description)
                    .foregroundStyle(BubbleColors.darkBlue)
                    .font(.footnote)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(
                GeometryReader{proxy in
                    Capsule()
                        .foregroundStyle(BubbleColors.lightBlue)
                        .onAppear{
                            size = proxy.size
                        }
                }
            )
            Spacer()
        }
        .offset(y: -size.height*0.5)
    }
}

#Preview {
    CapsuleHeader(title: "Title", description: "Description", offsetPercent: 0.0)
}

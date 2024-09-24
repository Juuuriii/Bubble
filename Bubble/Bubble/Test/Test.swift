//
//  Test.swift
//  Bubble
//
//  Created by Juri Huhn on 18.09.24.
//

import SwiftUI

struct Test: View {
    
    
    @State var visibily = true
    
    @Namespace var key
    
    var body: some View {
        HStack{
            Button{
                withAnimation{
                    visibily = true
                }
            } label: {
                Image(systemName: "person")
            }
            .padding(32)
            .background{
                if visibily {
                    Circle()
                        .matchedGeometryEffect(id: "circle", in: key)
                        .foregroundStyle(.orange)
                        
                }
            }
            Spacer()
                .frame(width: 250)
            Button{
                withAnimation{
                    visibily = false
                }
            } label: {
                Image(systemName: visibily ? "person" : "trash")
            }
            .padding()
            .background{
                if !visibily{
                    Circle()
                        .matchedGeometryEffect(id: "circle", in: key)
                        .foregroundStyle(.pink)
                }
            }
        }
    }
}

#Preview {
    Test()
}

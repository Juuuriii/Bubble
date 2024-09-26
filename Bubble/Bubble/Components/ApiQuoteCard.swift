//
//  ApiQuoteCard.swift
//  Bubble
//
//  Created by Juri Huhn on 26.09.24.
//

import SwiftUI

struct ApiQuoteCard: View {
    
    let quote: String
    let author: String
    
    var body: some View {
        VStack{
            VStack{
                CapsuleHeader(title: "Money Quote", description: "Get your daily Money Quote", offsetPercent: 0.5)
                
                VStack(alignment: .trailing) {
                    Text("\"\(quote)\"")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(BubbleColors.white)
                        .padding(.bottom)
                    
                    Text("- " + author)
                        .padding(.trailing, 32)
                        .foregroundStyle(BubbleColors.white)
                    
                }
                .padding(.horizontal)
                .padding(.vertical)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(BubbleColors.darkBlue)
                        .padding(.horizontal)
                        
                }
                .padding(.top, -16)
            }
            .padding(.bottom, 32)
            .background{
                SettingsBackground()
                    .foregroundStyle(BubbleColors.midBlue)
            }
            
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    ApiQuoteCard(quote: "isuef ui ehwi iuefh owieuf weiofj woeifj oweijf owiejfo iwejfiieiej ijei eij e ije iej e ji", author: "Bob Baumeister")
}

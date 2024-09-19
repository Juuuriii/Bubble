//
//  WalletViewTabs.swift
//  Bubble
//
//  Created by Juri Huhn on 17.09.24.
//

import SwiftUI

struct WalletViewTabs: View {
    
    @Binding var side: Bool
    @Binding var size: String
    @Binding var screen: ScreenWallet
    
    
    
    var body: some View {
        ZStack {
            HStack{
                if !side {
                    Spacer()
                }
                Text(size)
                    .foregroundStyle(.white.opacity(0.0))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .overlay{
                        Capsule()
                            .foregroundStyle(Color(hex: "14135B"))
                    }
                if side {
                    Spacer()
                }
            }
            HStack{
                Button{
                    withAnimation{
                        screen = .saving
                    }
                    
                } label: {
                    
                    Text("Saving Goals")
                        .foregroundStyle(side ? Color.white : Color(hex: "14135B"))
                }
                .padding(.horizontal)
                
                Spacer()
                Button{
                    withAnimation{
                        screen = .history
                    }
                } label: {
                    Text("History")
                        .foregroundStyle(side ? Color(hex: "14135B") : Color.white)
                }
                .padding(.horizontal)
            }
        }
        .padding(.horizontal, 64)
        .padding(.vertical)
        .onChange(of: screen) {
            switch screen {
            case .saving:
                withAnimation{
                    side = true
                    size = ScreenWallet.saving.rawValue
                }
            case .history:
                withAnimation{
                    side = false
                    size = ScreenWallet.history.rawValue
                }
            }
        }
    }
}



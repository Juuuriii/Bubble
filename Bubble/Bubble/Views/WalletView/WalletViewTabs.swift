//
//  WalletViewTabs.swift
//  Bubble
//
//  Created by Juri Huhn on 17.09.24.
//

import SwiftUI

struct WalletViewTabs: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    @State private var side = true
    @State private var colorSaving = BubbleColors.white
    @State private var colorHistory = BubbleColors.darkBlue
    
    
    @Namespace var key
    
    var body: some View {
        HStack{
            Button {
                withAnimation{
                    viewModel.screen = .saving
                }
            } label: {
                Text("Saving Goals")
                    .foregroundStyle(colorSaving)
                
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background{
                if side {
                    Capsule()
                        .matchedGeometryEffect(id: "tab", in: key)
                        .foregroundStyle(BubbleColors.darkBlue)
                }
            }
            
            Spacer()
            
            Button {
                withAnimation{
                    viewModel.screen = .history
                }
            } label: {
                Text("History")
                    .foregroundStyle(colorHistory)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background{
                if !side {
                    Capsule()
                        .matchedGeometryEffect(id: "tab", in: key)
                        .foregroundStyle(BubbleColors.darkBlue)
                }
            }
            
        }
        .padding(.vertical)
        .padding(.horizontal, 64)
        .onChange(of: viewModel.screen){
            
                switch viewModel.screen {
                case .saving:
                    withAnimation{
                        side = true
                        colorSaving = BubbleColors.white
                        colorHistory = BubbleColors.darkBlue
                    }
                case .history:
                    withAnimation{
                        side = false
                        colorSaving = BubbleColors.darkBlue
                        colorHistory = BubbleColors.white
                    }
                    
                }
            }
        
        }
    }




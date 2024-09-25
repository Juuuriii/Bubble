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
    @State private var colorSaving = Color.white
    @State private var colorHistory = Color(hex: "14135B")
    
    
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
                        .foregroundStyle(Color(hex: "14135B"))
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
                        .foregroundStyle(Color(hex: "14135B"))
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
                        colorSaving = .white
                        colorHistory = Color(hex: "14135B")
                    }
                case .history:
                    withAnimation{
                        side = false
                        colorSaving = Color(hex: "14135B")
                        colorHistory = .white
                    }
                    
                }
            }
        
        }
    }



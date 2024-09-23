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
    
    @Namespace var key
    
    var body: some View {
        HStack{
            Button {
                withAnimation{
                    viewModel.screen = .saving
                }
            } label: {
                Text("Saving Goals")
                
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
                    }
                case .history:
                    withAnimation{
                        side = false
                    }
                }
            }
        
        }
    }




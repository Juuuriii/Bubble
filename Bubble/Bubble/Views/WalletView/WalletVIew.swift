//
//  WalletVIew.swift
//  Bubble
//
//  Created by Juri Huhn on 16.09.24.
//

import SwiftUI

struct WalletVIew: View {
   
    
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack{
                    Text("Your Budget")
                        .foregroundStyle(.white)
                    Text("\(viewModel.bubbleUser?.balance ?? 0.0, specifier: "%.2f")€")
                        .font(.system(size: 38))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 8)
                .background{
                    Capsule()
                        .foregroundStyle(Color(hex: "14135B"))
                }
                
                WalletViewTabs(side: $viewModel.side, size: $viewModel.size, screen: $viewModel.screen)
           
                TabView(selection: $viewModel.screen) {
                    
                    SavingGoalsView(viewModel: SavingGoalsViewModel(uid: viewModel.uid))
                        .tag(ScreenWallet.saving)
                    
                    HistoryView(viewModel: HistoryViewModel(bubbleUser: viewModel.bubbleUser))
                        .tag(ScreenWallet.history)
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
            .tint(Color(hex: "4E28E9"))
            .background(Color(hex: "A4D8F5"))
            
        }
    }
}


#Preview {
    WalletVIew(viewModel: WalletViewModel(uid: "TPLxOOZc41a7AKZJFOiCDWiEyDf1"))
}

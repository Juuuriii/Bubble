//
//  WalletVIew.swift
//  Bubble
//
//  Created by Juri Huhn on 16.09.24.
//

import SwiftUI

struct WalletVIew: View {
    
    @StateObject var viewModel = WalletViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack{
                    Text("Your Budget")
                        .foregroundStyle(.white)
                    Text("\(viewModel.bubbleUser?.balance ?? 0.0, specifier: "%.2f")\(viewModel.getCurrency())")
                        .font(.system(size: 38))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 8)
                .background{
                    Capsule()
                        .foregroundStyle(Color(hex: "14135B"))
                }
                
                WalletViewTabs(viewModel: viewModel)
                
                
                
                TabView(selection: $viewModel.screen) {
                    
                    SavingGoalsView(viewModel: viewModel)
                        .tag(ScreenWallet.saving)
                    
                    HistoryView(viewModel: viewModel)
                        .tag(ScreenWallet.history)
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
            .tint(Color(hex: "4E28E9"))
            .background(Color(hex: "A4D8F5"))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        
                        switch viewModel.screen {
                        case .saving:
                            viewModel.toggleNewSavingGoalSheet()
                        case .history:
                            viewModel.toggleShowAddBalanceChangeSheet()
                        }
                        
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear{
                viewModel.addBubbleUserSnapshotListener()
                viewModel.addBalanceCHangeListener()
                viewModel.addSavingGoalsListener()
            }
            .onDisappear{
                viewModel.removeBubbleUserListener()
                viewModel.removeBalanceChangeListener()
                viewModel.removeSavinGoalListener()
            }
        }
    }
}


#Preview {
    WalletVIew()
}

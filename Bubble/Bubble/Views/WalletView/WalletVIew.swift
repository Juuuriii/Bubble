//
//  WalletVIew.swift
//  Bubble
//
//  Created by Juri Huhn on 16.09.24.
//

import SwiftUI

struct WalletVIew: View {
    
    @StateObject var viewModel = WalletViewModel()
    @Namespace var key
        
    var body: some View {
        NavigationStack {
            VStack{
                HStack(alignment: .bottom) {
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
                            .foregroundStyle(BubbleColors.darkBlue)
                    }
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
            .tint(BubbleColors.darkBlue)
            .background(BubbleColors.bgBlue)
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
                    .tint(BubbleColors.darkBlue)
                }
            }
            .onAppear{
                viewModel.addBalanceCHangeListener()
                viewModel.addSavingGoalsListener()
            }
            .onDisappear{
                viewModel.removeBalanceChangeListener()
                viewModel.removeSavinGoalListener()
            }
            .alert("Delete Saving Goal?", isPresented: $viewModel.deleteSavingGoalAlert) {
                Button("Cancel", role: .cancel) {
                    
                }
                Button("Delete", role: .destructive) {
                    viewModel.deleteSavingGoal()
                }
                
            }
        }
        }
}
#Preview {
    WalletVIew()
}

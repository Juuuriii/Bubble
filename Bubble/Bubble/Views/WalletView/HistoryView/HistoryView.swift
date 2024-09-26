//
//  HistoryView.swift
//  Bubble
//
//  Created by Juri Huhn on 16.09.24.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        VStack{
            ScrollView {
                
                    ForEach(viewModel.history) { balanceChange in
                        
                        var isFromSavingGoal: Bool {
                            balanceChange.sgID != ""
                        }
                        
                        VStack{
                            HStack{
                                HStack{
                                    Image(isFromSavingGoal ? "3coinsLight" : "3coins")
                                    Text(balanceChange.name)
                                        .font(.system(size: 20))
                                        .foregroundStyle(isFromSavingGoal ? BubbleColors.white : BubbleColors.darkBlue)
                                }
                                Spacer()
                                Text(balanceChange.type)
                                
                                    .foregroundStyle(isFromSavingGoal ? BubbleColors.white : BubbleColors.darkBlue)
                                Text("\(balanceChange.amount, specifier: "%.2f")\(viewModel.currency ?? "E")")
                                    .foregroundStyle(isFromSavingGoal ? BubbleColors.white : BubbleColors.darkBlue)
                            }
                            HStack{
                                Text(balanceChange.date, format: .dateTime.day().month().year())
                                    .foregroundStyle(isFromSavingGoal ? BubbleColors.white : BubbleColors.darkBlue)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background{
                                        Capsule()
                                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                            .foregroundStyle(isFromSavingGoal ? BubbleColors.white : BubbleColors.darkBlue)
                                    }
                                Spacer()
                                if balanceChange.sgID == "" {
                                    Button{
                                        
                                        viewModel.ddeleteBalanceChange(balanceChange: balanceChange)
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundStyle(BubbleColors.darkBlue)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background{
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(isFromSavingGoal ? BubbleColors.darkBlue : BubbleColors.bcColor)
                                    .shadow(radius: 4, y: 4)
                                Image(isFromSavingGoal ? "balanceChangeBackground2" : "balanceChangeBackground")
                                    .resizable()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    }
                
            }
        }
        .sheet(isPresented: $viewModel.showAddBalanceChangeSheet, content: {
            NewCashFlowSheet(viewModel: viewModel)
                .presentationDetents([.height(600), .large])

        })
            }
}


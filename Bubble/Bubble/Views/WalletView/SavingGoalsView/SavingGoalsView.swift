//
//  WalletView.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import SwiftUI

struct SavingGoalsView: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        VStack{
            ScrollView {
                
                ForEach($viewModel.savingGoals.filter{$0.finished.wrappedValue == false}){ savingGoal in
                    SavingGoalListItem(savingGoal: savingGoal, viewModel: viewModel)
                    .padding(.vertical, 4)
                 //   .animation(.linear(duration: 1), value: viewModel.savingGoals)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .sheet(isPresented: $viewModel.showNewSavingGoalSheet){
            NewGoalSheet(viewModel: viewModel)
                .presentationDetents([.height(700), .large])
        }
        .sheet(isPresented: $viewModel.showAddMoneySheet){
            
            if let selectedSavingGoal = viewModel.selectedSavingGoal {
                
                AddMoneySheet(viewModel: viewModel, savingGoal: selectedSavingGoal )
                    .presentationDetents([.height(200), .medium])
            }
        }
    }
}





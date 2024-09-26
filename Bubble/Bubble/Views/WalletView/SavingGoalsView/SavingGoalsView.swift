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
                
                ForEach($viewModel.savingGoals){ savingGoal in
                    
                    SavingGoalListItem(savingGoal: savingGoal, viewModel: viewModel)
                    .padding(.bottom, 8)
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





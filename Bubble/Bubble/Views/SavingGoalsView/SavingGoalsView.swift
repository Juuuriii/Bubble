//
//  WalletView.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import SwiftUI

struct SavingGoalsView: View {
    
    @StateObject var viewModel = SavingGoalsViewModel()
    
    var body: some View {
        VStack{
            ScrollView {
                
                ForEach($viewModel.savingGoals){ savingGoal in
                    
                    SavingGoalListItem(savingGoal: savingGoal){
                        viewModel.setSelectedSavingGoal(savingGoal: savingGoal.wrappedValue)
                        viewModel.toggleAddMoneySheet()
                    } delete: {
                        viewModel.deleteSavingGoal(id: savingGoal.id.uuidString)
                    }
                    .padding(.bottom, 8)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .sheet(isPresented: $viewModel.showNewSavingGoalSheet){
            NewSavingGoalSheet(viewModel: viewModel)
                .presentationDetents([.height(550), .large])
        }
        .sheet(isPresented: $viewModel.showAddMoneySheet){
            
            if let selectedSavingGoal = viewModel.selectedSavingGoal {
                
                AddMoneySheet(viewModel: viewModel, savingGoal: selectedSavingGoal )
                    .presentationDetents([.height(200)])
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    viewModel.toggleNewSavingGoalSheet()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}



#Preview {
    SavingGoalsView()
}

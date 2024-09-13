//
//  WalletView.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import SwiftUI

struct WalletView: View {
    @State private var progress = 0.0
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        
        NavigationStack{
            
            ScrollView {
                VStack() {
                    Text("Savings")
                        .font(.title)
                    Text("Budget & Track Future Expenses")
                        .font(.footnote)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background{
                    Capsule()
                        .foregroundStyle(Color(hex: "84C6EB"))
                }
                .padding()
                ForEach($viewModel.savingGoals){ savingGoal in
                    
                    SavingGoalListItem(savingGoal: savingGoal){
                        viewModel.setSelectedSavingGoal(savingGoal: savingGoal.wrappedValue)
                        viewModel.toggleAddMoneySheet()
                    }
                        .shadow(radius: 4, y: 4)
                        .padding(.bottom, 8)
                        
                }
                
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: "A4D8F5"))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        viewModel.toggleNewSavingGoalSheet()
                    } label: {
                        Image(systemName: "plus")
                        Text("Saving Goal")
                    }
                }
            }
            .toolbarBackground(Color(hex: "#49B0EA"), for: .navigationBar)
            .onAppear{
                viewModel.getSavingGoals()
               
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
        }
    }
}


#Preview {
    WalletView(viewModel: WalletViewModel(uid: nil))
}

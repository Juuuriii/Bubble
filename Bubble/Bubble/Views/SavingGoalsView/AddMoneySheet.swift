//
//  AddMoneySheet.swift
//  Bubble
//
//  Created by Juri Huhn on 13.09.24.
//

import SwiftUI

struct AddMoneySheet: View {
    
    @ObservedObject var viewModel: SavingGoalsViewModel
    var savingGoal: SavingGoal
    
    var body: some View {
        NavigationStack{
            VStack{
                Slider(value: $viewModel.addAmount, in: 1...(savingGoal.targetAmount - savingGoal.savedAmount), step: 1) {
                    Text("Add Money")
                } minimumValueLabel: {
                    Text("1€")
                } maximumValueLabel: {
                    Text("\(savingGoal.targetAmount - savingGoal.savedAmount, specifier: "%.0f")€")
                }
                Text("\(viewModel.addAmount, specifier: "%.0f")€")
                
                Button {
                    viewModel.addMoney()
                    viewModel.addAmount = 1.0
                    viewModel.toggleAddMoneySheet()
                } label: {
                    Text("Add Money")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        viewModel.addAmount = 1.0
                        viewModel.toggleAddMoneySheet()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}



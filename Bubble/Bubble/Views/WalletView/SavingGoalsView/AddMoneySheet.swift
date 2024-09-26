//
//  AddMoneySheet.swift
//  Bubble
//
//  Created by Juri Huhn on 13.09.24.
//

import SwiftUI

struct AddMoneySheet: View {
    
    @ObservedObject var viewModel: WalletViewModel
    var savingGoal: SavingGoal
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack {
                Slider(value: $viewModel.addAmount, in: 1...(savingGoal.targetAmount - savingGoal.savedAmount), step: 1) {
                Text("Add Money")
                        .foregroundStyle(BubbleColors.darkBlue)
                } minimumValueLabel: {
                    Text("1\(viewModel.getCurrency())")
                        .foregroundStyle(BubbleColors.darkBlue)
                } maximumValueLabel: {
                    Text("\(savingGoal.targetAmount - savingGoal.savedAmount, specifier: "%.0f")\(viewModel.getCurrency())")
                        .foregroundStyle(BubbleColors.darkBlue)
                }
                .tint(BubbleColors.purple)
               
                
                Text("\(viewModel.addAmount, specifier: "%.0f")\(viewModel.getCurrency())")
                        .foregroundStyle(BubbleColors.darkBlue)
                
                Button {
                    viewModel.addMoneyToSavingGoal()
                    viewModel.toggleAddMoneySheet()
                } label: {
                    Text("Add Money")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding()
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .padding()
                    .foregroundStyle(BubbleColors.lightBlue)
                    .shadow(radius: 10)
            }
            }
            .onAppear{
                viewModel.addAmount = 1.0
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BubbleColors.midBlue)

        }
    }
}

#Preview {
    AddMoneySheet(viewModel: WalletViewModel(), savingGoal: SavingGoal(id: "", name: "", type: "", targetDate: Date.now, repeats: "", targetAmount: 1000.0, savedAmount: 1.0, finished: false, uid: ""))
}


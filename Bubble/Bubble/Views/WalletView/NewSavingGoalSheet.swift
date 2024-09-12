//
//  NewSavingGoalSheet.swift
//  Bubble
//
//  Created by Juri Huhn on 11.09.24.
//

import SwiftUI



struct NewSavingGoalSheet: View {
    
    
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Text("Saving Goal")
                    .font(.title)
                
                VStack(alignment: .leading){
                    Text("Name of your Saving Goal")
                    
                    Text("e.g. Berlin trip, Overdue Electricity Bill")
                        .font(.footnote)
                    TextField("Name of your Saving Goal", text: $viewModel.savingGoalName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                VStack(alignment: .leading){
                    Text("Type of Saving")
                    
                    Text("e.g. Fitness, Self-Care, Family")
                        .font(.footnote)
                    TextField("Name of your Saving Goal", text: $viewModel.savingGoalType)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Type of Payment")
                            Text("e.g. Repeats yearly, one-time")
                                .font(.footnote)
                            Picker("Payment Type", selection: $viewModel.savingGoalPaymentType) {
                                ForEach(PaymentType.allCases, id: \.self){ paymentType in
                                    Text(paymentType.rawValue.capitalized)
                                        .tag(paymentType)
                                }
                            }
                            
                            
                        }
                        VStack(alignment: .trailing){
                            Text("Target Date")
                            Text("Set a deadline!")
                            DatePicker("", selection: $viewModel.savingGoalDeadline, in: Date.now..., displayedComponents: .date)
                        }
                    }
                }
                .padding()
                
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Target Amount in €")
                            
                            TextField("e.g. 1000€", text: $viewModel.savingGoalTargetAmount)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numbersAndPunctuation)
                        }
                        VStack(alignment: .leading){
                            Text("Amount Saved in €")
                            
                            TextField("e.g. 10€", text: $viewModel.savingGoalAmountSaved)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numbersAndPunctuation)
                        }
                    }
                }
                .padding()
                
                Button{
                    viewModel.createSavingGoal()
                    viewModel.toggleNewSavingGoalSheet()
                    viewModel.getSavingGoals()
                } label: {
                    Text("Save")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        viewModel.toggleNewSavingGoalSheet()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    NewSavingGoalSheet(viewModel: WalletViewModel(uid: ""))
}

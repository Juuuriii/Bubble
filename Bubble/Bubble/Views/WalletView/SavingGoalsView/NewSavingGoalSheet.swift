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
                    Text("Name")
                    
                   
                        
                    TextField("Name of your Saving Goal", text: $viewModel.savingGoalName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                VStack(alignment: .leading){
                    Text("Category")
                    
                    
                        
                    TextField("e.g. Family, Personal", text: $viewModel.savingGoalType)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Type of Payment")
                            Picker("Payment Type", selection: $viewModel.savingGoalPaymentType) {
                                ForEach(PaymentType.allCases, id: \.self){ paymentType in
                                    Text(paymentType.rawValue.capitalized)
                                        .tag(paymentType)
                                }
                            }
                            
                            
                        }
                        VStack(alignment: .trailing){
                            Text("Deadline")
                            
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
    NewSavingGoalSheet(viewModel: WalletViewModel())
}

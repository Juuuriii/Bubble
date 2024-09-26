//
//  NewGoalSheet.swift
//  Bubble
//
//  Created by Juri Huhn on 26.09.24.
//

import SwiftUI

struct NewGoalSheet: View {
    
    
    
    @ObservedObject var viewModel: WalletViewModel
    
    
    var body: some View {
            VStack{
                Text("Saving Goal")
                    .font(.title)
                    .foregroundStyle(BubbleColors.darkBlue)
                    .padding(.bottom, 24)
                VStack(alignment: .leading){
                    Text("Name of Your Saving Goal")
                        .foregroundStyle(BubbleColors.darkBlue)
                    
                    TextField("e.g. Vacation, New PC", text: $viewModel.savingGoalName)
                        .padding(.vertical, 12)
                        .padding(.horizontal,8)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(BubbleColors.white)
                        }
                }
                .padding(.bottom, 24)
                VStack(alignment: .leading){
                    Text("Type of Saving Goal")
                        .foregroundStyle(BubbleColors.darkBlue)
                    TextField("e.g. Family, Personal, Self-Care", text: $viewModel.savingGoalType)
                        .padding(.vertical, 12)
                        .padding(.horizontal,8)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(BubbleColors.white)
                        }
                    
                }
                .padding(.bottom, 24)
                HStack {
                    VStack(alignment: .leading){
                        Text("Target Amount (\(viewModel.getCurrency()))")
                            .foregroundStyle(BubbleColors.darkBlue)
                        
                        TextField("e.g. 1000", text: $viewModel.savingGoalTargetAmount)
                            .keyboardType(.decimalPad)
                            .padding(.vertical, 12)
                            .padding(.horizontal,8)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(BubbleColors.white)
                            }
                    }
                    Spacer()
                        .frame(width: 16)
                    VStack(alignment: .leading){
                        Text("Saved Amount (\(viewModel.getCurrency()))")
                            .foregroundStyle(BubbleColors.darkBlue)
                        
                        TextField("e.g. 100", text: $viewModel.savingGoalAmountSaved)
                            .keyboardType(.decimalPad)
                            .padding(.vertical, 12)
                            .padding(.horizontal,8)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(BubbleColors.white)
                            }
                    }
                }
                .padding(.bottom, 24)
                
                VStack(alignment: .leading){
                    Text("Deadline")
                        .foregroundStyle(BubbleColors.darkBlue)
                    
                    Text(viewModel.savingGoalDeadline, format: .dateTime.day().month().year())
                        
                        .padding(.vertical, 13)
                        .padding(.horizontal,8)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(BubbleColors.white)
                        }
                        .overlay {
                            DatePicker("", selection: $viewModel.savingGoalDeadline , in: Date.now..., displayedComponents: .date)
                                .blendMode(.destinationOver)
                        }
                }
                
                Button {
                    viewModel.addSavingGoal()
                    viewModel.toggleNewSavingGoalSheet()
                } label: {
                    Text("Save")
                        .bold()
                }
                .tint(BubbleColors.darkBlue)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.top, 40)
               
            }
            .padding(.vertical ,40)
            .padding(.horizontal, 32)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .padding()
                    .foregroundStyle(BubbleColors.lightBlue)
                    .shadow(radius: 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BubbleColors.midBlue)
    }
}

#Preview {
    NewGoalSheet(viewModel: WalletViewModel())
}

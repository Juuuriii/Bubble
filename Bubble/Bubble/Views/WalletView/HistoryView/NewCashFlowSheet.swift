//
//  NewCashFlowSheet.swift
//  Bubble
//
//  Created by Juri Huhn on 25.09.24.
//

import SwiftUI

struct NewCashFlowSheet: View {
    
    
    
    @ObservedObject var viewModel: WalletViewModel
    
    @Namespace var key
    
    var body: some View {
            VStack{
                Text("Cash Flow")
                    .font(.title)
                    .foregroundStyle(BubbleColors.darkBlue)
                    .padding(.bottom, 24)
                VStack(alignment: .leading){
                    Text("Name of the Cash Flow")
                        .foregroundStyle(BubbleColors.darkBlue)
                    
                    TextField("e.g. Salary, Rent, Gym", text: $viewModel.balanceChangeName)
                        .padding(.vertical, 12)
                        .padding(.horizontal,8)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(BubbleColors.white)
                        }
                }
                .padding(.bottom, 24)
                VStack(alignment: .leading){
                    Text("Type of Cash Flow")
                        .foregroundStyle(BubbleColors.darkBlue)
                    HStack {
                        Button {
                            withAnimation{
                                viewModel.balanceChangeType = .income
                            }
                        } label: {
                            Text("Income")
                                .foregroundStyle(BubbleColors.white)
                                .padding(.vertical, 12)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity)
                                .background{
                                    if viewModel.balanceChangeType == .income {
                                        RoundedRectangle(cornerRadius: 8)
                                            .matchedGeometryEffect(id: "cfSheet", in: key)
                                            .foregroundStyle(BubbleColors.darkBlue)
                                    }
                                }
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            withAnimation {
                                viewModel.balanceChangeType = .expense
                            }
                        } label: {
                            Text("Expence")
                                .foregroundStyle(BubbleColors.white)
                                .padding(.vertical, 12)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity)
                                .background{
                                    if viewModel.balanceChangeType == .expense {
                                        RoundedRectangle(cornerRadius: 8)
                                            .matchedGeometryEffect(id: "cfSheet", in: key)
                                            .foregroundStyle(BubbleColors.darkBlue)
                                    }
                                }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding(.bottom, 24)
                HStack {
                    VStack(alignment: .leading){
                        Text("Amount (€)")
                            .foregroundStyle(BubbleColors.darkBlue)
                        
                        TextField("e.g. 1000", text: $viewModel.balanceChangeAmount)
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
                        Text("Date")
                            .foregroundStyle(BubbleColors.darkBlue)
                        
                        Text(viewModel.balanceChangeDate, format: .dateTime.day().month().year())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 13)
                            .padding(.horizontal,8)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(BubbleColors.white)
                            }
                            .overlay {
                                DatePicker("", selection: $viewModel.balanceChangeDate , in: Date.now..., displayedComponents: .date)
                                    .blendMode(.destinationOver)
                            }
                    }
                }
                Button {
                    viewModel.aaddBalanceChange()
                    viewModel.toggleShowAddBalanceChangeSheet()
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
    NewCashFlowSheet(viewModel: WalletViewModel())
}

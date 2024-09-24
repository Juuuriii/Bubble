//
//  AddBalanceChangeSheet.swift
//  Bubble
//
//  Created by Juri Huhn on 17.09.24.
//

import SwiftUI

struct AddBalanceChangeSheet: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Text("Cash Flow")
                    .font(.title)
                
                VStack(alignment: .leading){
                    Text("Name")
                    
                   
                        
                    TextField("Name of your Income/Expense", text: $viewModel.balanceChangeName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                Picker("Type", selection: $viewModel.balanceChangeType){
                    ForEach(BalanceChangeType.allCases, id: \.rawValue){ type in
                        Text(type.name)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                
                VStack(alignment: .leading){
                    DatePicker("Date", selection: $viewModel.balanceChangeDate, in: ...Date.now, displayedComponents: .date)
                }
                .padding()
                
                VStack{
                    HStack{
                        VStack(alignment: .center){
                            Text("Amount in \(viewModel.getCurrency())")
                            
                            TextField("e.g. 1000\(viewModel.getCurrency())", text: $viewModel.balanceChangeAmount)
                                .frame(width: 200)
                                .textFieldStyle(.roundedBorder)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numbersAndPunctuation)
                        }
                    }
                }
                .padding()
                
                Button{
                    viewModel.aaddBalanceChange()
                    
                    viewModel.toggleShowAddBalanceChangeSheet()
                } label: {
                    Text("Save")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        viewModel.toggleShowAddBalanceChangeSheet()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}



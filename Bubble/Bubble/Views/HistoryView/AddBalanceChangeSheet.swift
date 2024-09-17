//
//  AddBalanceChangeSheet.swift
//  Bubble
//
//  Created by Juri Huhn on 17.09.24.
//

import SwiftUI

struct AddBalanceChangeSheet: View {
    
    @ObservedObject var viewModel: HistoryViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Text("Cash Flow")
                    .font(.title)
                
                VStack(alignment: .leading){
                    Text("Name")
                    
                   
                        
                    TextField("Name of your Income/Expense", text: .constant(""))
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                Picker("Type", selection: .constant(BalanceChangeType.expense)){
                    ForEach(BalanceChangeType.allCases, id: \.rawValue){ type in
                        Text(type.name)
                    }
                }
                .pickerStyle(.segmented)
                
                VStack(alignment: .leading){
                            DatePicker("Date", selection: .constant(Date.now), in: Date.now..., displayedComponents: .date)
                }
                .padding()
                
                VStack{
                    HStack{
                        VStack(alignment: .center){
                            Text("Amount in €")
                            
                            TextField("e.g. 1000€", text: .constant(""))
                                .frame(width: 200)
                                .textFieldStyle(.roundedBorder)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numbersAndPunctuation)
                        }
                    }
                }
                .padding()
                
                Button{
                    
                } label: {
                    Text("Save")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}



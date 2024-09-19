//
//  HistoryView.swift
//  Bubble
//
//  Created by Juri Huhn on 16.09.24.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVStack{
                    ForEach(viewModel.history) { balanceChange in
                        VStack{
                            HStack{
                                HStack{
                                    Image("3coins")
                                    Text(balanceChange.name)
                                        .font(.system(size: 20))
                                        .foregroundStyle(Color(hex: "14135B"))
                                }
                                Spacer()
                                Text(balanceChange.type)
                                
                                    .foregroundStyle(Color(hex: "14135B"))
                                Text("\(balanceChange.amount, specifier: "%.2f")€")
                                    .foregroundStyle(Color(hex: "14135B"))
                            }
                            HStack{
                                Text(balanceChange.date, format: .dateTime.day().month().year())
                                    .foregroundStyle(Color(hex: "14135B"))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background{
                                        Capsule()
                                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                            .foregroundStyle(Color(hex: "14135B"))
                                    }
                                Spacer()
                                Button{
                                    viewModel.deleteBalanceChange(id: balanceChange.id, amount: balanceChange.amount, type: BalanceChangeType(rawValue:balanceChange.type) ?? BalanceChangeType.expense)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                        .padding()
                        .background{
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(Color(hex: "CFE0EA"))
                                    .shadow(radius: 4, y: 4)
                                Image("balanceChangeBackground")
                                    .resizable()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showAddBalanceChangeSheet, content: {
            AddBalanceChangeSheet(viewModel: viewModel)
        })
    }
}


//
//  SavingGoalListItem.swift
//  Bubble
//
//  Created by Juri Huhn on 12.09.24.
//

import SwiftUI

@MainActor
struct SavingGoalListItem: View {
    
    @Binding var savingGoal: SavingGoal
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
            VStack{
                HStack{
                    VStack{
                        Button{
                           
                            viewModel._deleteSavingGoal(savingGoal: savingGoal)
                            
                        }label: {
                            Image("editIconSavingGoal")
                        }
                    }
                    .offset(y:-16)
                    VStack{
                        HStack{
                            Text(savingGoal.name)
                                .lineLimit(1)
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        ProgressView(value: savingGoal.savedAmount, total: savingGoal.targetAmount)
                            .background{
                                Capsule()
                                    .foregroundStyle(Color(hex:"49B0EA"))
                            }
                        HStack{
                            Spacer()
                            Text("\(savingGoal.savedAmount, specifier: "%.0f")\(viewModel.getCurrency()) / \(savingGoal.targetAmount, specifier: "%.0f")\(viewModel.getCurrency())")
                                .font(.system(size: 12))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal, 8)
                    VStack{
                        Button{
                            
                        }label: {
                            Image("addButtonSavingGoal")
                        }
                        .simultaneousGesture(LongPressGesture().onEnded{ _ in
                            viewModel.setSelectedSavingGoal(savingGoal: savingGoal)
                            viewModel.toggleAddMoneySheet()
                        })
                        .simultaneousGesture(TapGesture().onEnded {
                            viewModel.setSelectedSavingGoal(savingGoal: savingGoal)
                            viewModel.addMoneyToSavingGoalQT()
                        })
                        .offset(y: 6)
                    }
                }
                .padding(.horizontal)
                HStack(spacing: 8){
                    HStack{
                        Image("deadlineIcon")
                        Text(savingGoal.targetDate, format: .dateTime.day().month().year())
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                            
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background{
                        Capsule()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                            .foregroundStyle(.white)
                    }
                    HStack{
                        Spacer()
                        Text(savingGoal.type)
                            .font(.system(size: 12))
                            .foregroundStyle(Color(hex: "14135B"))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            
                        Spacer()
                    }
                    .background{
                        Capsule()
                            .foregroundStyle(Color(hex: "49B0EA"))
                    }
                }
                .padding(.horizontal, 8)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background{
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color(hex: "14135B"))
                        .shadow(radius: 4, y: 4)
                        
                    Image("SavingGoalBackground")
                        .resizable()
                  //      .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(.horizontal, 8)
    }
}




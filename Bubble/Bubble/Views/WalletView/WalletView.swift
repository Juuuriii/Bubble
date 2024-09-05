//
//  WalletView.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import SwiftUI

struct WalletView: View {
    @State private var progress = 0.0
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                ForEach(viewModel.savingGoals){ savingGoal in
                    VStack{
                        HStack{
                            VStack{
                                Image("editIconSavingGoal")
                                Spacer()
                            }
                            VStack{
                                Text(savingGoal.name)
                                    .foregroundStyle(.white)
                                ProgressView(value: progress, total: 100)
                                Text("\(savingGoal.savedAmount)/\(savingGoal.targetAmount)")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                            }
                            VStack{
                                Image("addButtonSavingGoal")
                            }
                        }
                        
                        HStack{
                            HStack{
                                Image(systemName: "circle")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                                Text("04 Jun. 2024")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background{
                                Capsule()
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                    .foregroundStyle(.white)
                            }
                            Text(savingGoal.type)
                                .font(.system(size: 14))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background{
                                    Capsule()
                                        .foregroundStyle(Color(hex: "49B0EA"))
                                        .frame(maxWidth: .infinity)
                                }
                        }
                    }
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color(hex: "14135B"))
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: "A4D8F5"))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        viewModel.createSavingGoal()
                        viewModel.getSavingGoals()
                    } label: {
                        Image(systemName: "plus")
                        Text("Saving Goal")
                    }
                }
            }
            .onAppear{
                viewModel.getSavingGoals()
            }
        }
    }
}


#Preview {
    WalletView(viewModel: WalletViewModel(uid: nil))
}

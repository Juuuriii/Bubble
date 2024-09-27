//
//  AchiementView.swift
//  Bubble
//
//  Created by Juri Huhn on 26.09.24.
//

import SwiftUI

struct AchievementView: View {
    
    @StateObject var viewModel = AchievementViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                VStack{
                    CapsuleHeader(title: "Achievements", description: "Check out your Progress", offsetPercent: 0.5)
                    
                    VStack{
                        HStack{
                            Text("Finished SavingGoals:")
                                .foregroundStyle(BubbleColors.white)
                                
                            Spacer()
                            Text("\(viewModel.count)")
                                .foregroundStyle(BubbleColors.white)
                               
                        }
                        Spacer()
                            .frame(height: 26)
                        HStack{
                            Text("Total Amount Saved:")
                                .foregroundStyle(BubbleColors.white)
                                
                            Spacer()
                            Text("\(viewModel.totalAmount, specifier: "%.2f")€")
                                .foregroundStyle(BubbleColors.white)
                                
                        }
                    }
                    .padding()
                    .padding(.horizontal)
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(BubbleColors.darkBlue)
                            .padding(.horizontal)
                    }
                    .padding(.top, -16)
                    
                }
                .padding(.bottom, 32)
                .background{
                    SettingsBackground()
                        .foregroundStyle(BubbleColors.midBlue)
                }
                .onAppear{
                    viewModel.getFinishedGoals()
                }
                
                
            }
            .padding(.horizontal, 8)
            .padding(.top, 48)
            
            if viewModel.goals.isEmpty {
            
                    Text("No finished Goals yet")
                        .font(.title2)
                        .foregroundStyle(BubbleColors.darkBlue.opacity(0.5))
                        .padding(.top, 200)
                
            } else {
                ForEach(viewModel.goals){ goal in
                    AchievementItem(savingGoal: goal)
                        .padding(.vertical, 4)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BubbleColors.bgBlue)
    }
}

#Preview {
    AchievementView()
}

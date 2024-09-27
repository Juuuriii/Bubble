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
                            .shadow(radius: 10)
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
            .padding(.horizontal)
            .padding(.top, 48)
            
            
                HStack{
                    Text("Finished Saving Goals")
                        .foregroundStyle(BubbleColors.darkBlue)
                        .font(.title)
                    Spacer()
                }
                .padding(16)
                ForEach(viewModel.goals){ goal in
                    AchievementItem(savingGoal: goal)
                        .padding(.vertical, 4)
                }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BubbleColors.bgBlue)
    }
}

#Preview {
    AchievementView()
}

//
//  AchiementView.swift
//  Bubble
//
//  Created by Juri Huhn on 26.09.24.
//

import SwiftUI

struct AchievementView: View {
    
    
    
    var body: some View {
        VStack{
            VStack{
                VStack{
                    CapsuleHeader(title: "Achievements", description: "Check out your Progress", offsetPercent: 0.5)
                    
                    VStack{
                        HStack{
                            Text("Finished SavingGoals:")
                                .foregroundStyle(BubbleColors.darkBlue)
                                .font(.title2)
                            Spacer()
                            Text("4")
                                .foregroundStyle(BubbleColors.darkBlue)
                                .font(.title2)
                        }
                        Spacer()
                            .frame(height: 26)
                        HStack{
                            Text("Total Amount Saved:")
                                .foregroundStyle(BubbleColors.darkBlue)
                                .font(.title2)
                            Spacer()
                            Text("10000")
                                .foregroundStyle(BubbleColors.darkBlue)
                                .font(.title2)
                        }
                    }
                    .padding()
                    .padding(.horizontal)
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(BubbleColors.lightBlue)
                            .padding(.horizontal)
                    }
                    .padding(.top, -16)
                    
                }
                .padding(.bottom, 32)
                .background{
                    SettingsBackground()
                        .foregroundStyle(BubbleColors.midBlue)
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 48)
            
            ScrollView {
                
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BubbleColors.bgBlue)
    }
}

#Preview {
    AchievementView()
}

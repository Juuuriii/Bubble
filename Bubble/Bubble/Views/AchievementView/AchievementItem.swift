//
//  AchievementItem.swift
//  Bubble
//
//  Created by Juri Huhn on 27.09.24.
//

import SwiftUI

struct AchievementItem: View {
    
    let savingGoal: SavingGoal
    
    var body: some View {
        VStack{
            HStack{
                Text(savingGoal.name)
                    .lineLimit(1)
                    .font(.title2)
                    .foregroundStyle(BubbleColors.white)
                Spacer()
                Text("\(savingGoal.targetAmount, specifier: "%.2f")€")
                    .foregroundStyle(BubbleColors.white)
            }
            
            HStack {
                Text(savingGoal.type)
                    .foregroundStyle(BubbleColors.white)
                Spacer()
                
                HStack{
                    
                    Image("smallTrophy")
                    Text(savingGoal.targetDate, format: .dateTime.day().month().year())
                        .foregroundStyle(BubbleColors.midBlue)
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(BubbleColors.white)
                }
            }
            
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(BubbleColors.midBlue)
                    .shadow(radius: 4, y: 4)
                
                Image("achievementBg")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    AchievementItem(savingGoal: SavingGoal(id: "", name: "New PC", type: "Personal", targetDate: Date.now, repeats: "", targetAmount: 1000.0, savedAmount: 100.0, finished: false, uid: ""))
}

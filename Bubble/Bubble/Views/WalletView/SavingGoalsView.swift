//
//  WalletView.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import SwiftUI

struct SavingGoalsView: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    
    
    
    var body: some View {
        
        
        VStack{
            
            
            
            
            ScrollView {
                
                ForEach($viewModel.savingGoals){ savingGoal in
                    
                    SavingGoalListItem(savingGoal: savingGoal){
                        viewModel.setSelectedSavingGoal(savingGoal: savingGoal.wrappedValue)
                        viewModel.toggleAddMoneySheet()
                    } delete: {
                        viewModel.deleteSavingGoal(id: savingGoal.id.uuidString)
                    }
                    
                    .padding(.bottom, 8)
                    
                }
                
            }
            .frame(maxWidth: .infinity)
            
        }
        
    }
}



#Preview {
    SavingGoalsView(viewModel: WalletViewModel(uid: "TPLxOOZc41a7AKZJFOiCDWiEyDf1"))
}

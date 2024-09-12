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
            GeometryReader { proxy in
            ScrollView {
                VStack() {
                    Text("Savings")
                        .font(.title)
                    Text("Budget & Track Future Expenses")
                        .font(.footnote)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background{
                    Capsule()
                        .foregroundStyle(Color(hex: "84C6EB"))
                }
                .padding()
                ForEach($viewModel.savingGoals){ savingGoal in
                       
                           SavingGoalListItem(savingGoal: savingGoal)
                            .shadow(radius: 4, y: 4)
                            .padding(.bottom, 8)
                        }
                    }
            .background(Color(hex: "A4D8F5"))
                
            }
            
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        viewModel.toggleNewSavingGoalSheet()
                    } label: {
                        Image(systemName: "plus")
                        Text("Saving Goal")
                    }
                }
            }
            .toolbarBackground(Color(hex: "#49B0EA"), for: .navigationBar)
            .onAppear{
                viewModel.getSavingGoals()
            }
            .sheet(isPresented: $viewModel.showNewSavingGoalSheet){
                NewSavingGoalSheet(viewModel: viewModel)
            }
        }
    }
}


#Preview {
    WalletView(viewModel: WalletViewModel(uid: nil))
}

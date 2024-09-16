//
//  WalletVIew.swift
//  Bubble
//
//  Created by Juri Huhn on 16.09.24.
//

import SwiftUI

struct WalletVIew: View {
    
    enum ScreenWallet: String {
        case saving = "Saving Goals"
        case history = "History"
    }
    
    @State var screen: ScreenWallet = .saving
    
    @State var side = true
    @State var size = "Saving Goals"
    
    @ObservedObject var viewModel: WalletViewModel
    
    
    var body: some View {
        NavigationStack {
            VStack{
                
                ZStack {
                    HStack{
                        if !side {
                            Spacer()
                        }
                        
                        Text(size)
                            .foregroundStyle(.white.opacity(0.0))
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .overlay{
                                
                                Capsule()
                                    .foregroundStyle(Color(hex: "14135B"))
                                
                            }
                        
                        
                        if side {
                            Spacer()
                        }
                    }
                    
                    
                    HStack{
                        Button{
                            withAnimation{
                                screen = .saving
                            }
                            
                        } label: {
                            
                            Text("Saving Goals")
                                .foregroundStyle(side ? Color.white : Color(hex: "14135B"))
                            
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        Button{
                            withAnimation{
                                screen = .history
                            }
                        } label: {
                            Text("History")
                                .foregroundStyle(side ? Color(hex: "14135B") : Color.white)
                        }
                        .padding(.horizontal)
                    }
                    
                }
                .padding(.horizontal, 64)
                .padding(.vertical)
                .onChange(of: screen) {
                    switch screen {
                    case .saving:
                        withAnimation{
                            side = true
                            size = ScreenWallet.saving.rawValue
                        }
                    case .history:
                        withAnimation{
                            side = false
                            size = ScreenWallet.history.rawValue
                        }
                    }
                }
                
               
                
                TabView(selection: $screen) {
                    
                    SavingGoalsView(viewModel: viewModel)
                        .tag(ScreenWallet.saving)
                    
                    HistoryView(viewModel: HistoryViewModel(uid: "TPLxOOZc41a7AKZJFOiCDWiEyDf1"))
                        .tag(ScreenWallet.history)
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
            .tint(Color(hex: "4E28E9"))
            .background(Color(hex: "A4D8F5"))
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
            .sheet(isPresented: $viewModel.showNewSavingGoalSheet){
                NewSavingGoalSheet(viewModel: viewModel)
                    .presentationDetents([.height(550), .large])
            }
            .sheet(isPresented: $viewModel.showAddMoneySheet){
                
                if let selectedSavingGoal = viewModel.selectedSavingGoal {
                    
                    AddMoneySheet(viewModel: viewModel, savingGoal: selectedSavingGoal )
                        .presentationDetents([.height(200)])
                }
            }
        }
    }
}


#Preview {
    WalletVIew(viewModel: WalletViewModel(uid: "TPLxOOZc41a7AKZJFOiCDWiEyDf1"))
}

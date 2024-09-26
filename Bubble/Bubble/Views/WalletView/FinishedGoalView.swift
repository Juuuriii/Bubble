//
//  FinishedGoalView.swift
//  Bubble
//
//  Created by Juri Huhn on 26.09.24.
//

import SwiftUI

struct FinishedGoalView: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        VStack{
            Button("Close"){
                withAnimation{
                    viewModel.finishedGoalOverlay = false
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    FinishedGoalView(viewModel: WalletViewModel())
}

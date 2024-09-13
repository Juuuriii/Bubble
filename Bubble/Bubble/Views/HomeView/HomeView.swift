//
//  HomeView.swift
//  Bubble
//
//  Created by Juri Huhn on 13.09.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack{
            Text("\(viewModel.quote.first?.quote ?? "")")
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "A4D8F5"))
        
    }
}

#Preview {
    HomeView()
}

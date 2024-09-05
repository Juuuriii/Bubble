//
//  HomeView.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        TabView {
            Text("Home")
                .tabItem { Label("Home", systemImage: "house") }
            
            WalletView(viewModel: WalletViewModel(uid: authViewModel.user?.uid))
                .tabItem { Label("Wallet", systemImage: "dollarsign") }
            
            Text("Dungeon")
                .tabItem { Label("Dungeon", systemImage: "circle") }
            VStack{
                Text("Settings")
                Button("Logout"){
                    authViewModel.logout()
                }
            }
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel())
}

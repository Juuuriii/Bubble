//
//  HomeView.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
            
            WalletVIew()
                .tabItem { Label("Wallet", image: "walletIcon") }
            
            Text("Dungeon")
                .tabItem { Label("Dungeon", image: "bubbleIcon") }
            
            SettingsVIew(authViewModel: authViewModel)
                .tabItem { Label("Settings", systemImage: "gear") }
            
        }
        .tint(Color(hex: "#4E28E9"))
        .onAppear{
            
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color(hex: "#14135B"))
            UITabBar.appearance().barTintColor = UIColor(Color(hex: "#49B0EA"))
        }
        .toolbarBackground(Color(hex: "#49B0EA"), for: .navigationBar)
        
    }
}

#Preview {
    MainView(authViewModel: AuthViewModel())
}

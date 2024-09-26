//
//  HomeView.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    
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
        .tint(BubbleColors.purple)
        .onAppear{
            UITabBar.appearance().unselectedItemTintColor = UIColor(BubbleColors.darkBlue)
            UITabBar.appearance().barTintColor = UIColor(BubbleColors.bgBlue)
            
        }
    }
}

#Preview {
    MainView(authViewModel: AuthViewModel())
}

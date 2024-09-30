//
//  HomeView.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import SwiftUI

enum TabScreen {
    case home, wallet, achievement, dungeon, settings
}

struct MainView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @State var screen: TabScreen = .home
    
    var body: some View {
        TabView(selection: $screen) {
            
            HomeView(screen: $screen)
                .tabItem { Label("Home", systemImage: "house") }
                .tag(TabScreen.home)
            
            WalletVIew()
                .tabItem { Label("Wallet", image: "walletIcon") }
                .tag(TabScreen.wallet)
            
            AchievementView()
                .tabItem { Label("Progress", systemImage: "trophy")}
                .tag(TabScreen.achievement)
            
            GameVIew()
                .tabItem { Label("Dungeon", image: "bubbleIcon") }
                .tag(TabScreen.dungeon)
            
            SettingsVIew(authViewModel: authViewModel)
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .tag(TabScreen.settings)
            
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

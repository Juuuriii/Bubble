//
//  BubbleApp.swift
//  Bubble
//
//  Created by Juri Huhn on 19.08.24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct BubbleApp: App {
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        print("Firebase wurde konfiguriert")
    }
    @StateObject var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            
            if authViewModel.user != nil {
                HomeView(authViewModel: authViewModel)
            } else {
                AuthView(viewModel: authViewModel)
            }
            
           
        }
    }
}

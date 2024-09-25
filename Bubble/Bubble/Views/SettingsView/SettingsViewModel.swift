//
//  SettingsViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 19.09.24.
//

import Foundation
import FirebaseAuth

enum QuickAddAmount: Double, CaseIterable {
    case one = 1.0
    case ten = 10.0
    case hundret = 100.0
    case thousend = 1000.0
    
    var display: String {
        switch self {
        case .one:
            "1"
        case .ten:
            "10"
        case .hundret:
            "100"
        case .thousend:
            "1000"
        }
    }
}

enum AppCurrency: String, CaseIterable {
    case euro = "€"
    case dollar = "$"
}

@MainActor
class SettingsViewModel: ObservableObject {
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
    
    @Published var quickAddAmount: QuickAddAmount = .ten
    @Published var currency: AppCurrency = .euro
    
    @Published var bubbleUser: BubbleUser?
    
    
    init(){
        getBubbleUser()
    }
    
    
    
    func getBubbleUser(){
        
        guard let uid = authClient.checkAuth()?.uid else {
            return
        }
        
        Task {
           await bubbleUser = firestoreClient.getUser(uid: uid)
            
            guard let user = bubbleUser else {
                return
            }
            
            if let userCurrency = AppCurrency(rawValue: user.currency) {
                currency = userCurrency
            }
            
            if let userQuickAddAmount = QuickAddAmount(rawValue: user.quickAddAmount) {
                quickAddAmount = userQuickAddAmount
            }
            
            
        }
    }
    
    func updateCurrency() {
        Task{
            do{
               try await firestoreClient.updateCurrency(uid: authClient.checkAuth()?.uid ?? "", currency: currency.rawValue)
            } catch {
                print(error)
            }
        }
    }
    
    func updateQuickAddAmount() {
        Task{
            do{
               try await firestoreClient.updateQuickAddAmount(uid: authClient.checkAuth()?.uid ?? "", amount: quickAddAmount.rawValue)
            } catch {
                print(error)
            }
        }
    }
}

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
    private var uid: String?
    
    init(){
        self.uid = authClient.checkAuth()?.uid
        firestoreClient.addUserListener(uid: uid) { user in
            self.bubbleUser = user
            self.quickAddAmount = self.setQuickAddAmount(quickAddAmount: user.quickAddAmount)
            self.currency = self.setCurrency(currency: user.currency)
        }
    }
    
    
    private func setQuickAddAmount(quickAddAmount :Double) -> QuickAddAmount {
        
        if let quickAddAmount = QuickAddAmount(rawValue: quickAddAmount) {
            return quickAddAmount
        } else {
            return QuickAddAmount.ten
        }
    }
    
    private func setCurrency(currency: String) -> AppCurrency {
        if let currency = AppCurrency(rawValue: currency) {
            return currency
        } else {
            return AppCurrency.euro
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

//
//  WalletViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import Foundation

enum PaymentType: String, CaseIterable {
    case yearly
    case monthly
    case weekly
    case oneTime = "One-Time"
}

@MainActor
class WalletViewModel: ObservableObject {
    
    
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
    @Published var showNewSavingGoalSheet = false
    
    @Published var savingGoalName = ""
    @Published var savingGoalType = ""
    @Published var savingGoalPaymentType: PaymentType = .oneTime
    @Published var savingGoalDeadline = Date.now
    @Published var savingGoalTargetAmount = ""
    @Published var savingGoalAmountSaved = ""
    
    let uid: String?
    
    init(uid: String?) {
        self.uid = uid
    }
    
    @Published var savingGoals = [SavingGoal]()
    
    func getSavingGoals() {
        Task {
            do {
             savingGoals = try await firestoreClient.getSavingGoals(uid: uid ?? "")
            } catch {
                print(error)
            }
        }
    }
    
    func createSavingGoal() {
        do {
            
            guard let savingGoalTargetAmount = Double(savingGoalTargetAmount) else {
                return
            }
            
            guard let savingGoalAmountSaved = Double(savingGoalAmountSaved) else {
                return
            }
            
            try firestoreClient.createSavingGoal(uid: uid ?? "",
                                                 name: savingGoalName,
                                                 type: savingGoalType,
                                                 targetDate: savingGoalDeadline,
                                                 repeats: savingGoalPaymentType.rawValue,
                                                 targetAmount: savingGoalTargetAmount,
                                                 savedAmount: savingGoalAmountSaved)
        } catch {
            print(error)
        }
    }
    
    func deleteSavingGoal(id: String) {
        firestoreClient.deleteSavingGoal(uid: uid ?? "", id: id)
    }
    
    func toggleNewSavingGoalSheet() {
        showNewSavingGoalSheet.toggle()
    }
}

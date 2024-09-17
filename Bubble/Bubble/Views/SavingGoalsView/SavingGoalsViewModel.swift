//
//  WalletViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import Foundation
import SwiftUI

enum PaymentType: String, CaseIterable {
    case yearly
    case monthly
    case weekly
    case oneTime = "One-Time"
}

@MainActor
class SavingGoalsViewModel: ObservableObject {
    
    
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
    
    
    @Published var showAddMoneySheet = false
    @Published var addAmount = 1.0
    
    @Published var showNewSavingGoalSheet = false
    
    @Published var savingGoalName = ""
    @Published var savingGoalType = ""
    @Published var savingGoalPaymentType: PaymentType = .oneTime
    @Published var savingGoalDeadline = Date.now
    @Published var savingGoalTargetAmount = ""
    @Published var savingGoalAmountSaved = ""
    
    @Published var selectedSavingGoal: SavingGoal?
    
    @Published var fixAddingAmount = 10.0
    
    
    
     var uid: String?
    
    init() {
        self.uid = authClient.checkAuth()?.uid
        
        savingGoalsSnapshotListener()
    }
    
    @Published var savingGoals = [SavingGoal]()
    
    
    func savingGoalsSnapshotListener() {
        firestoreClient.store.collection("users")
            .document(uid ?? "")
            .collection("wallet")
            .addSnapshotListener{ querySnapshot, error in
                
                if let error = error {
                    print(error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach { change in
                    
                    switch change.type {
                    case .added:
                        if let data = try? change.document.data(as: SavingGoal.self) {
                            
                            withAnimation{
                                self.savingGoals.append(data)
                            }
                        }
                    case .modified:
                        if let data = try? change.document.data(as: SavingGoal.self) {
                            
                            if let index = self.savingGoals.firstIndex(where: { $0.id == data.id }){
                                
                                withAnimation{
                                    self.savingGoals[index].savedAmount = data.savedAmount
                                }
                            }
                        }
                        
                    case .removed:
                        if let data = try? change.document.data(as: SavingGoal.self) {
                            
                            withAnimation{
                                self.savingGoals.removeAll{ $0.id == data.id }
                            }
                        }
                    }
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
    
    func addMoney() {
        
        if let selectedSavingGoal = selectedSavingGoal {
            
            let newAmount = selectedSavingGoal.savedAmount + addAmount
            
            Task{
                do{
                    try await firestoreClient.updateAmountSaved(uid: uid ?? "", id: selectedSavingGoal.id.uuidString, newAmount: newAmount)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func deleteSavingGoal(id: String) {
        firestoreClient.deleteSavingGoal(uid: uid ?? "", id: id)
    }
    
    func toggleNewSavingGoalSheet() {
        showNewSavingGoalSheet.toggle()
    }
    
    func toggleAddMoneySheet() {
        showAddMoneySheet.toggle()
    }
    
    func setSelectedSavingGoal(savingGoal: SavingGoal){
        selectedSavingGoal = savingGoal
    }
}

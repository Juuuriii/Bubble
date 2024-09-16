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
class WalletViewModel: ObservableObject {
    
    
    
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
    
    @Published var bubbleUser: BubbleUser?
    
    let uid: String?
    
    init(uid: String?) {
        self.uid = uid
        
        getBubbleUser()
        savingGoalsSnapshotListener()
    }
    
    @Published var savingGoals = [SavingGoal]()
    
    
    func getBubbleUser() {
        
        firestoreClient.store.collection("users")
            .document(uid ?? "")
            .addSnapshotListener{ querySnapshot, error in
               
                guard let document = querySnapshot else {
                      print("Error fetching document: \(error!)")
                      return
                    }
                guard document.data() != nil else {
                      print("Document data was empty.")
                      return
                    }
                
                self.bubbleUser = try? document.data(as: BubbleUser.self)
                
            }
    }
    
    func getSavingGoals() {
        Task {
            do {
             savingGoals = try await firestoreClient.getSavingGoals(uid: uid ?? "")
            } catch {
                print(error)
            }
        }
    }
    
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
                    if change.type == .added {
                        
                    }
                    
                    switch change.type {
                    case .added:
                        if let data = try? change.document.data(as: SavingGoal.self) {
                            
                            self.savingGoals.append(data)
                            
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
                            
                            self.savingGoals.removeAll{ $0.id == data.id }
                            
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
    
    /**
    func addMoneyWithButton(amount: Double, id: UUID) {
        
        guard let index = savingGoals.firstIndex(where: {id == $0.id}) else {
            return
        }
        
        withAnimation{
            savingGoals[index].savedAmount += amount
        }
    }
    */
}

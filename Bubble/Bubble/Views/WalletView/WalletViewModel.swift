//
//  WalletViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 17.09.24.
//

import SwiftUI
import Firebase

enum ScreenWallet: String {
    case saving = "Saving Goals"
    case history = "History"
}

class WalletViewModel: ObservableObject {
    
    
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
    
    @Published var screen: ScreenWallet = .saving
    @Published var side = true
    @Published var size = "Saving Goals"
    
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
    @Published var savingGoals = [SavingGoal]()
    
        
    @Published var history = [BalanceChange]()
    @Published var balanceChangeName = ""
    @Published var balanceChangeAmount = ""
    @Published var balanceChangeType: BalanceChangeType = .expense
    @Published var balanceChangeCurrentBalance = 0.0
    @Published var balanceChangeDate = Date.now
    @Published var showAddBalanceChangeSheet = false
    
    
    
    @Published var bubbleUser: BubbleUser?
    private var bubbleUserListener: ListenerRegistration?
    private var balanceChagesListener: ListenerRegistration?
    private var savingGoalsListener: ListenerRegistration?
    
    var uid: String?
    
    init() {
        self.uid = authClient.checkAuth()?.uid
    }
    
    func addBubbleUserSnapshotListener() {
        
        
        
        bubbleUserListener = firestoreClient.store.collection("users")
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
    
    func removeBubbleUserListener() {
        guard (bubbleUserListener != nil) else {
            return
        }
        bubbleUserListener?.remove()
    }
    
    
    func addBalanceChangeSnapshotlistener() {
        balanceChagesListener = firestoreClient.store.collection("users")
            .document(uid ?? "")
            .collection("history")
            .addSnapshotListener{ querySnapshot, error in
                print("history listener triggert!!!!!")
                if let error = error {
                    print(error)
                    return
                }
                querySnapshot?.documentChanges.forEach{ change in
                    switch change.type {
                    case .added:
                        if let data = try? change.document.data(as: BalanceChange.self) {

                                    self.history.insert(data, at: 0)
                        }
                    case .modified:
                        print("How?")
                    case .removed:
                        if let data = try? change.document.data(as: BalanceChange.self) {
                            withAnimation{
                                self.history.removeAll{ $0.id == data.id }
                            }
                        }
                    }
                  self.history = self.history.sorted{$0.date > $1.date }
                }
            }
    }
    
    func removeBalanceChangeListener(){
        balanceChagesListener?.remove()
        history.removeAll()
        print("!!!!remove history!!!")
    }
    
    func addBalanceChange(){
        guard let amount = Double(balanceChangeAmount) else {
            return
        }
        Task {
            do {
                try firestoreClient.addBalanceChange(uid: uid ?? "",
                                                     name: balanceChangeName,
                                                     amount: amount,
                                                     type: balanceChangeType.rawValue,
                                                     currentBalance: balanceChangeCurrentBalance,
                                                     date: balanceChangeDate)
                updateUserBalance()
            } catch {
                print(error)
            }
        }
        history.forEach{
            print("\($0.date)")
            print($0.name)
        }
    }
    
    func deleteBalanceChange(id: String, amount: Double, type: BalanceChangeType) {
        Task{
            do {
                try await firestoreClient.updateUserBalance(uid: uid ?? "", oldAmount: bubbleUser?.balance, amount: amount, type: type, delete: true)
            } catch {
                print(error)
            }
        }
        firestoreClient.deleteBalanceChange(uid: uid ?? "", id: id)
    }
    
    func addSavingGoalsListener() {
       savingGoalsListener = firestoreClient.store.collection("users")
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
                                withAnimation{
                                    self.savingGoals.removeAll{ $0.id == data.id }
                                }
                            }
                        }
                    }
            }
    }
    
    func removeSavinGoalListener(){
        savingGoalsListener?.remove()
        savingGoals.removeAll()
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
            
            try firestoreClient.addBalanceChange(uid: uid ?? "",
                                                 name: "Saving Goal \(savingGoalName)",
                                                 amount: savingGoalAmountSaved,
                                                 type: BalanceChangeType.expense.rawValue,
                                                 currentBalance: balanceChangeCurrentBalance,
                                                 date: Date.now)
        } catch {
            print(error)
        }
    }
    
    func setSelectedSavingGoal(savingGoal: SavingGoal){
        selectedSavingGoal = savingGoal
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
    
    private func updateUserBalance(){
        
        guard let amount = Double(balanceChangeAmount) else {
            return
        }
        
         Task{
             do {
                 try await firestoreClient.updateUserBalance(uid: uid ?? "", oldAmount: bubbleUser?.balance, amount: amount, type: balanceChangeType)
             } catch {
                 print(error)
             }
         }
     }
     
     
    
    
    func toggleNewSavingGoalSheet() {
        showNewSavingGoalSheet.toggle()
    }
    
    func toggleAddMoneySheet() {
        showAddMoneySheet.toggle()
    }
    
    func toggleShowAddBalanceChangeSheet() {
        showAddBalanceChangeSheet.toggle()
    }
    
    
}

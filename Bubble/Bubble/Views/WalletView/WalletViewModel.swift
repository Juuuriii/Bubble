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
    
    
    //Firestore Snapshot Listner
    
    func addBubbleUserSnapshotListener() {
        
        guard let uid = uid else {
            return
        }
        
        bubbleUserListener = firestoreClient.store.collection("users")
            .document(uid)
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
    
    
    
    func addBalanceCHangeListener(){
        
        guard let uid = uid else {
            return
        }
        
        firestoreClient.store.collectionGroup("history")
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener{ querySnapshot, error in
                print("-history listener triggert-")
                if let error = error {
                    print(error)
                    return
                }
                querySnapshot?.documentChanges.forEach{ change in
                    switch change.type {
                    case .added:
                        if let data = try? change.document.data(as: BalanceChange.self) {
                            
                            self.history.insert(data, at: 0)
                            print("balance change added!")
                            
                        }
                    case .modified:
                        print("How?")
                    case .removed:
                        if let data = try? change.document.data(as: BalanceChange.self) {
                            withAnimation{
                                self.history.removeAll{ $0.id == data.id }
                            }
                            print("balance change removed!")
                        }
                    }
                    self.history = self.history.sorted{$0.date > $1.date }
                }
            }
    }
    
    func removeBalanceChangeListener(){
        balanceChagesListener?.remove()
        history.removeAll()
    }
    
    
    func addSavingGoalsListener() {
        
        guard let uid = uid else {
            return
        }
        
        savingGoalsListener = firestoreClient.store.collection("users")
            .document(uid)
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
    
    // Saving Goals Functions
    
    
    func setSelectedSavingGoal(savingGoal: SavingGoal){
        selectedSavingGoal = savingGoal
    }
    
    func addSavingGoal(){
        
        guard let user = bubbleUser else {
            return
        }
        
        guard let targetAmount = Double(savingGoalTargetAmount) else {
            return
        }
        
        guard let savedAmount = Double(savingGoalAmountSaved) else {
            return
        }
        
        let id = UUID().uuidString
        
        let savingGoal = SavingGoal(id: id,
                                    name: savingGoalName,
                                    type: savingGoalType,
                                    targetDate: savingGoalDeadline,
                                    repeats: savingGoalPaymentType.rawValue,
                                    targetAmount: targetAmount,
                                    savedAmount: savedAmount,
                                    finished: false, uid: user.id)
        
        do {
            try firestoreClient.addSavingGoal(savingGoal: savingGoal)
        } catch {
            print(error)
        }
        
        if savedAmount > 0 {
            addBalanceChange(from: savingGoal, isNewGoal: true, isDelete: false)
        }
    }
    
    func addMoneyToSavingGoal() {
        
        guard let user = bubbleUser else {
            return
        }
        
        guard let selectedSavingGoal = selectedSavingGoal else {
            return
        }
        
        let newAmount = selectedSavingGoal.savedAmount + addAmount
        
        Task {
            do {
                try await firestoreClient.updateAmountSaved(uid: user.id, id: selectedSavingGoal.id, newAmount: newAmount)
            } catch {
                print(error)
            }
        }
        
        addBalanceChange(from: selectedSavingGoal, isNewGoal: false, isDelete: false)
    }
    
    func _deleteSavingGoal(savingGoal: SavingGoal) {
        
        firestoreClient.deleteSavingGoal(uid: savingGoal.uid, id: savingGoal.id)
        
        addBalanceChange(from: savingGoal, isNewGoal: false, isDelete: true)
    }
    
    func toggleNewSavingGoalSheet() {
        showNewSavingGoalSheet.toggle()
    }
    
    func toggleAddMoneySheet() {
        showAddMoneySheet.toggle()
    }
    
    // Balance Change Functions
    
    
    
    func toggleShowAddBalanceChangeSheet() {
        showAddBalanceChangeSheet.toggle()
    }
    
    private func updateBalance(amount: Double, isIncome: Bool){
        
        Task{
            do {
                guard let user = bubbleUser else {
                    return
                }
                
                let newAmount = isIncome ? (user.balance + amount) : (user.balance - amount)
                
                try await firestoreClient.updateBalance(uid: user.id, newAmount: newAmount)
                
            } catch {
                print(error)
            }
        }
    }
    
    func aaddBalanceChange(){
        
        guard let user = bubbleUser else {
            return
        }
        
        guard let amount = Double(balanceChangeAmount) else {
            return
        }
        
        let balanceChange = BalanceChange(uid: user.id, name: balanceChangeName, amount: amount, type: balanceChangeType.rawValue, date: Date.now)
        
        let isIncome = balanceChangeType == .income
        
        
        do{
            try firestoreClient._addBalanceChange(balanceChange: balanceChange)
            
        } catch {
            print(error)
        }
        
        updateBalance(amount: amount, isIncome: isIncome)
    }
    
    private func addBalanceChange(from savingGoal: SavingGoal, isNewGoal: Bool, isDelete: Bool){
        
        guard let user = bubbleUser else {
            return
        }
        
        var amount = 0.0
        var name = ""
        var type = BalanceChangeType.expense.rawValue
        
        if isNewGoal {
            amount = savingGoal.savedAmount
            name = savingGoalName
            
        } else {
            amount = addAmount
            name = savingGoal.name
        }
        
        if isDelete {
            type = BalanceChangeType.income.rawValue
            name = "Deleted \(savingGoal.name)"
            amount = savingGoal.savedAmount
        }
        
        let balanceChange = BalanceChange(uid: user.id, name: name, amount: amount, type: type , date: Date.now, sgID: savingGoal.id)
        
        do {
            if isDelete {
                try firestoreClient._addBalanceChange(balanceChange: balanceChange)
            } else {
                try firestoreClient._addBalanceChange(balanceChange: balanceChange, from: savingGoal.id)
            }
        } catch {
            print(error)
        }
        updateBalance(amount: amount, isIncome: isDelete ? true : false)
    }
    
    
    func ddeleteBalanceChange(balanceChange: BalanceChange){
        
        guard let type = BalanceChangeType(rawValue: balanceChange.type) else {
            return
        }
        
        var isIncome: Bool {
            switch type {
            case .income:
                false
            case .expense:
                true
            }
        }
        
        firestoreClient.deleteBalanceChange(uid: balanceChange.uid, id: balanceChange.id)
        
        updateBalance(amount: balanceChange.amount, isIncome: isIncome)
        
    }
}

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
    @Published var savingGoalAmountSaved = "0"
    @Published var selectedSavingGoal: SavingGoal?
    @Published var savingGoals = [SavingGoal]()
    @Published var finishedGoals = [SavingGoal]()
    @Published var finishedGoalOverlay = false
    @Published var deleteSavingGoalAlert = false
    
    @Published var history = [BalanceChange]()
    @Published var balanceChangeName = ""
    @Published var balanceChangeAmount = ""
    @Published var balanceChangeType: BalanceChangeType = .expense
    @Published var balanceChangeCurrentBalance = 0.0
    @Published var balanceChangeDate = Date.now
    @Published var showAddBalanceChangeSheet = false
    
    
    @Published var currency: String?
    @Published var quickAddAmount: Double?
    
    
    
    private var balanceChagesListener: ListenerRegistration?
    private var savingGoalsListener: ListenerRegistration?
    
    
    @Published var bubbleUser: BubbleUser?
    private var uid: String?
    
    init() {
        self.uid = authClient.checkAuth()?.uid
        firestoreClient.addUserListener(uid: uid) { user in
            self.bubbleUser = user
            self.currency = user.currency
            self.quickAddAmount = user.quickAddAmount
        }
    }
    
    
    //MARK: Firestore Snapshot Listner
    
    private func fetchCurrency() {
        guard let user = bubbleUser else {
            return
        }
        currency = user.currency
    }
    
    func getCurrency() -> String {
        guard let currency = currency else {
            return "€"
        }
        return currency
    }
    
    private func fetchQuickAddAmount() {
        guard let user = bubbleUser else {
            return
        }
        quickAddAmount = user.quickAddAmount
        print("Quick Add Amount = \(quickAddAmount ?? -1.0)")
    }
    
    func addBalanceCHangeListener(){
        
        guard let uid = uid else {
            return
        }
        firestoreClient.store.collectionGroup("history")
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener{ querySnapshot, error in
                if let error = error {
                    print(error)
                    return
                }
                querySnapshot?.documentChanges.forEach{ change in
                    switch change.type {
                    case .added:
                        if let data = try? change.document.data(as: BalanceChange.self) {
                            if !self.history.contains(where: {$0.id == data.id}) {
                                self.history.insert(data, at: 0)
                            }
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
                            if data.finished {
                                if !self.finishedGoals.contains(where: {$0.id == data.id }){
                                    self.finishedGoals.append(data)
                                }
                            } else {
                                self.savingGoals.append(data)
                            }
                            self.adjustSavingGoalCount()
                        }
                    case .modified:
                        if let data = try? change.document.data(as: SavingGoal.self) {
                            if let index = self.savingGoals.firstIndex(where: { $0.id == data.id }){
                                
                            
                                
                                withAnimation(.linear(duration: 1)) {
                                    self.savingGoals[index].savedAmount = data.savedAmount
                                   
                                }
                                
                                if data.finished {
                                    withAnimation(.linear(duration: 0.5).delay(1)){
                                        self.finishedGoals.append(data)
                                        self.savingGoals.remove(at: index)
                                        self.adjustSavingGoalCount()
                                    }
                                }
                            
                            }
                        }
                    case .removed:
                        
                            if let data = try? change.document.data(as: SavingGoal.self) {
                                
                                if let index = self.savingGoals.firstIndex(where: {$0.id == data.id}) {
                                    withAnimation{
                                       _ = self.savingGoals.remove(at: index)
                                    }
                                }
                                self.adjustSavingGoalCount()
                            }
                        }
                    
                }
            }
    }
    
    func removeSavinGoalListener(){
        savingGoalsListener?.remove()
        savingGoals.removeAll()
    }
    
    //MARK: Saving Goals Functions
    
    func isSavingGoalButtonDisabled() -> Bool {
        
        guard let targetAmount = Double(savingGoalTargetAmount) else {
            return true
        }
        
        guard let savedAmount = Double(savingGoalAmountSaved) else {
            return true
        }
        
        return savingGoalName.isEmpty || savingGoalType.isEmpty || targetAmount <= savedAmount
    }
    
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
            addBalanceChange(create: savingGoal)
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
                let finished = newAmount == selectedSavingGoal.targetAmount
                var date = selectedSavingGoal.targetDate
                if finished {
                    date = Date.now
                }
                try await firestoreClient.updateAmountSaved(uid: user.id, id: selectedSavingGoal.id, newAmount: newAmount, isFinished: finished, dateFinished: date)
                
            } catch {
                print(error)
            }
        }
        addBalanceChange(from: selectedSavingGoal)
    }
    
    func addMoneyToSavingGoalQT() {
        
        guard let user = bubbleUser else {
            return
        }
        guard let selectedSavingGoal = selectedSavingGoal else {
            return
        }
        guard var quickAddAmount = quickAddAmount else {
            return
        }
        if selectedSavingGoal.savedAmount + quickAddAmount > selectedSavingGoal.targetAmount {
            quickAddAmount = selectedSavingGoal.targetAmount - selectedSavingGoal.savedAmount
        }
        let newAmount = selectedSavingGoal.savedAmount + quickAddAmount
        Task {
            do {
                let finished = newAmount == selectedSavingGoal.targetAmount
                var date = selectedSavingGoal.targetDate
                if finished {
                    date = Date.now
                }
                try await firestoreClient.updateAmountSaved(uid: user.id, id: selectedSavingGoal.id, newAmount: newAmount, isFinished: finished, dateFinished: date)
            } catch {
                print(error)
            }
        }
        addBalanceChange(quickAdd: selectedSavingGoal, amount: quickAddAmount)
    }
    
    func deleteSavingGoal() {
        
        guard let savingGoal = selectedSavingGoal else {
            return
        }
        
        firestoreClient.deleteSavingGoal(uid: savingGoal.uid, id: savingGoal.id)
        addBalanceChange(delete: savingGoal)
        
    }
    
    func toggleNewSavingGoalSheet() {
        resetSavingGoalTextFields()
        showNewSavingGoalSheet.toggle()
    }
    
    func toggleAddMoneySheet() {
        showAddMoneySheet.toggle()
    }
    
    private func resetSavingGoalTextFields() {
        savingGoalName = ""
        savingGoalType = ""
        savingGoalDeadline = Date.now
        savingGoalAmountSaved = "0"
        savingGoalTargetAmount = ""
    }
    
    func adjustSavingGoalCount() {
        
        guard let uid = uid else {
            return
        }
        let newAmount = savingGoals.count
        let newAmountFinished = finishedGoals.count
        Task{
            do {
                try await firestoreClient.updateAmountOfGoals(uid: uid, newAmount: newAmount, newAmountFinished: newAmountFinished)
                
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: Balance Change Functions
    
    
    func isSaveBalanceChangeButtonDisabled() -> Bool {
        
        guard let amount = Double(balanceChangeAmount) else {
            return true
        }
        
        return balanceChangeName.isEmpty || amount <= 0
    }
    
    func toggleShowAddBalanceChangeSheet() {
        resetBalanceChangeTextFields()
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
    
    private func addBalanceChange(delete savingGoal: SavingGoal){
        
        guard let user = bubbleUser else {
            return
        }
        let amount = savingGoal.savedAmount
        let name = "Deleted \(savingGoal.name)"
        let type = BalanceChangeType.income.rawValue
        let balanceChange = BalanceChange(uid: user.id, name: name, amount: amount, type: type , date: Date.now, sgID: savingGoal.id)
        do {
            try firestoreClient._addBalanceChange(balanceChange: balanceChange)
        } catch {
            print(error)
        }
        updateBalance(amount: amount, isIncome: true)
    }
    
    private func addBalanceChange(create savingGoal: SavingGoal){
        
        guard let user = bubbleUser else {
            return
        }
        let amount = savingGoal.savedAmount
        let name = savingGoalName
        let type = BalanceChangeType.expense.rawValue
        let balanceChange = BalanceChange(uid: user.id, name: name, amount: amount, type: type , date: Date.now, sgID: savingGoal.id)
        do {
            try firestoreClient._addBalanceChange(balanceChange: balanceChange, from: savingGoal.id)
        } catch {
            print(error)
        }
        updateBalance(amount: amount, isIncome: false)
    }
    
    private func addBalanceChange(quickAdd savingGoal: SavingGoal, amount: Double){
        
        guard let user = bubbleUser else {
            return
        }
        
        let name = savingGoal.name
        let type = BalanceChangeType.expense.rawValue
        let balanceChange = BalanceChange(uid: user.id, name: name, amount: amount, type: type , date: Date.now, sgID: savingGoal.id)
        do {
            try firestoreClient._addBalanceChange(balanceChange: balanceChange, from: savingGoal.id)
        } catch {
            print(error)
        }
        updateBalance(amount: amount, isIncome: false)
    }
    
    private func addBalanceChange(from savingGoal: SavingGoal){
        
        guard let user = bubbleUser else {
            return
        }
        let amount = addAmount
        let name = savingGoal.name
        let type = BalanceChangeType.expense.rawValue
        let balanceChange = BalanceChange(uid: user.id, name: name, amount: amount, type: type , date: Date.now, sgID: savingGoal.id)
        do {
            try firestoreClient._addBalanceChange(balanceChange: balanceChange, from: savingGoal.id)
            
        } catch {
            print(error)
        }
        updateBalance(amount: amount, isIncome: false)
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
    
    private func resetBalanceChangeTextFields() {
        balanceChangeName = ""
        balanceChangeAmount = ""
        balanceChangeDate = Date.now
    }
}

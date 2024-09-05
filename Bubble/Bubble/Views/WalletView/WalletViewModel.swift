//
//  WalletViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import Foundation

@MainActor
class WalletViewModel: ObservableObject {
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
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
            try firestoreClient.createSavingGoal(uid: uid ?? "", name: "Urlaub", type: "Family", targetDate: Date.now, repeats: "Yearly", targetAmount: 1000.0, savedAmount: 0.0)
        } catch {
            print(error)
        }
    }
}

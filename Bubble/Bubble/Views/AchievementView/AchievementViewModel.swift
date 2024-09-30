//
//  AchievementViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 27.09.24.
//

import Foundation

@MainActor
class AchievementViewModel: ObservableObject {
    
    private let authClient = AuthClient.shared
    private let firestoreClient = FirestoreClient.shared
    
    private var uid: String?
    
    @Published var goals = [SavingGoal]()
    @Published var count = 0
    @Published var totalAmount = 0.0
    @Published var currency = "€"
    
    @Published var bubbleUser: BubbleUser?
    
    init() {
        uid = authClient.checkAuth()?.uid
        firestoreClient.addUserListener(uid: uid) { user in
            self.bubbleUser = user
            self.currency = user.currency
        }
    }
    
    func getFinishedGoals() {
        guard let uid = uid else {
            return
        }
        Task{
            do{
               goals = try await firestoreClient.getFinishedGoals(uid: uid)
                count = goals.count
                
                goals.forEach{ goal in
                    
                    totalAmount += goal.targetAmount
                    
                }
            } catch {
                print(error)
            }
        }
    }
}

//
//  HomeViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 13.09.24.
//

import Foundation
import Firebase

@MainActor
class HomeViewModel: ObservableObject {
    
    private let apiClient = ApiClient.shared
    private let firestoreClient = FirestoreClient.shared
    private let authClient = AuthClient.shared
    
    @Published var quote = [Quote]()
    
    @Published var savingGoalsAmount = 0
    @Published var finishedSavingGoals = 0
    
    @Published var showAchievementView = false
    
    @Published var user: BubbleUser?
    private var uid: String?
    
    init(){
        fetchQuote()
        self.uid = authClient.checkAuth()?.uid
        firestoreClient.addUserListener(uid: uid ?? "") { user in
            self.user = user
            self.savingGoalsAmount = user.savingGoalsAmount
            self.finishedSavingGoals = user.finishedSavingGoals
        }
    }
    
    func fetchQuote(){
        Task{
            do {
            quote = try await apiClient.fetchQuote()
            } catch {
                print(error)
            }
        }
    }
}

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
    
    @Published var bubbleUser: BubbleUser?
    private var bubbleUserListener: ListenerRegistration?
    private var uid: String?

    init(){
        fetchQuote()
        self.uid = authClient.checkAuth()?.uid
    }
    
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

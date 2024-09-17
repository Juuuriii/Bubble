//
//  WalletViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 17.09.24.
//

import Foundation

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
    
    @Published var bubbleUser: BubbleUser?
    let uid: String?

    init(uid: String?) {
        self.uid = uid
        
        addBubbleUserSnapshotListener()
    }
    
    func addBubbleUserSnapshotListener() {
        
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
    
    
    
}

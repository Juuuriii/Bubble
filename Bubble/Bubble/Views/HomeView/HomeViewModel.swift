//
//  HomeViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 13.09.24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
   private let apiClient = ApiClient.shared
    @Published var quote = [Quote]()
    
    init(){
        fetchQuote()
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

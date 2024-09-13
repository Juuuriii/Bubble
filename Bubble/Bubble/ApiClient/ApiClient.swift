//
//  ApiClient.swift
//  Bubble
//
//  Created by Juri Huhn on 13.09.24.
//

import Foundation

class ApiClient {
    
    static let shared = ApiClient()
    
    private init(){}
    
    func fetchQuote() async throws -> Quote {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.api-ninjas.com"
        urlComponents.path = "/v1/quotes"

        urlComponents.queryItems = [
            URLQueryItem(name: "category", value: "money")
        ]
        
        guard let url = urlComponents.url else {
            fatalError("invalid url")
        }
        
        
    }
    
}

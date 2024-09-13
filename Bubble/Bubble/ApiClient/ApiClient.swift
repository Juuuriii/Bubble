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
    
    func fetchQuote() async throws -> [Quote] {
        
        guard let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=money") else {
            fatalError("invalid url")
        }

        let header = [
            "x-api-key": ApiKey.key
        ]

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = header
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print(jsonString)
        }
        
        
        return try JSONDecoder().decode([Quote].self, from: data)
    }
    
}

//
//  BalanceChange.swift
//  Bubble
//
//  Created by Juri Huhn on 16.09.24.
//

import Foundation

enum BalanceChangeType: String {
    case income, expense
}

struct BalanceChange: Codable{
    
    var id: String = UUID().uuidString
    let uid: String
    let name: String
    let amount: Double
    let type: String
    let currentBalance: Double
    let date: Date
    
    
}

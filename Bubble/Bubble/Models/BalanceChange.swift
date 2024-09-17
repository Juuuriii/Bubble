//
//  BalanceChange.swift
//  Bubble
//
//  Created by Juri Huhn on 16.09.24.
//

import Foundation

enum BalanceChangeType: String, CaseIterable {
    case income = "+"
    case expense = "-"
    
    var name: String {
        switch self {
        case .income:
            "Income"
        case .expense:
            "Expense"
        }
    }
}

struct BalanceChange: Codable, Identifiable {
    
    var id: String = UUID().uuidString
    let uid: String
    let name: String
    let amount: Double
    let type: String
    let currentBalance: Double
    let date: Date
    
    
}

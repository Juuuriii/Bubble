//
//  SavingGoal.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import Foundation

enum PaymentType: String, CaseIterable {
    case yearly
    case monthly
    case weekly
    case oneTime = "One-Time"
}

struct SavingGoal: Codable, Identifiable, Equatable {
    
    var id: String
    let name: String
    let type: String
    let targetDate: Date
    let repeats: String
    let targetAmount: Double
    var savedAmount: Double
    var finished: Bool
    let uid: String
    
}


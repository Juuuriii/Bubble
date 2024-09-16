//
//  SavingGoal.swift
//  Bubble
//
//  Created by Juri Huhn on 04.09.24.
//

import Foundation



struct SavingGoal: Codable, Identifiable {
    
    var id: UUID = UUID()
    let name: String
    let type: String
    let targetDate: Date
    let repeats: String
    let targetAmount: Double
    var savedAmount: Double
    let finished: Bool
    let uid: String
    
}

//
//  BubbleUser.swift
//  Bubble
//
//  Created by Juri Huhn on 21.08.24.
//

import Foundation

struct BubbleUser: Codable {
    
    let id: String
    let email: String
    let username: String
    var balance: Double = 0.0
    var currency: String
    
}

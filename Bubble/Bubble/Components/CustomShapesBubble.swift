//
//  CustomShapesBubble.swift
//  Bubble
//
//  Created by Juri Huhn on 25.09.24.
//

import SwiftUI

struct AchievementBackgroundShape: Shape {
    
    let cornerRadius = 20.0
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minX + 20))
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius * 2, y: rect.minY + 16))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius * 2 + 16),
                              control: CGPoint(x: rect.maxX, y: rect.minY + 16))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius * 2))
            path.addQuadCurve(to: CGPoint(x: rect.maxX - cornerRadius * 2, y: rect.maxY),
                              control: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius * 2, y: rect.maxY - 16))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius * 2 - 16),
                              control: CGPoint(x: rect.minX, y: rect.maxY - 16))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
    
}

struct SettingsBackground: Shape {
    
    let cornerRadius = 20.0
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))

            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius * 2, y: rect.minY + 20))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius * 2 + 20),
                              control: CGPoint(x: rect.maxX, y: rect.minY + 20))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius * 2))
            path.addQuadCurve(to: CGPoint(x: rect.maxX - cornerRadius * 2, y: rect.maxY),
                              control: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius * 2, y: rect.maxY - 10))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius * 2 - 10),
                              control: CGPoint(x: rect.minX, y: rect.maxY - 10))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            
        }
    }
    
    
}

//
//  Test.swift
//  Bubble
//
//  Created by Juri Huhn on 30.09.24.
//

import SwiftUI

struct Test: View {
    var body: some View {
        AchievementBackgroundShape()
            .stroke(lineWidth: 3)
            .frame(width: 300, height: 200)
            .padding()
    }
}

#Preview {
    Test()
}

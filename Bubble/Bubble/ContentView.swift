//
//  ContentView.swift
//  Bubble
//
//  Created by Juri Huhn on 19.08.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("rectangle")
                .background(.orange)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

//
//  AuthView.swift
//  Bubble
//
//  Created by Juri Huhn on 23.08.24.
//

import SwiftUI


struct AuthView: View {
    
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        VStack{
            Text("Hello")
        }
    }
}

#Preview {
    AuthView()
}

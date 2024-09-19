//
//  SettingsVIew.swift
//  Bubble
//
//  Created by Juri Huhn on 19.09.24.
//

import SwiftUI

struct SettingsVIew: View {
    
    @StateObject var viewModel = SettingsViewModel()
    @ObservedObject var authViewModel: AuthViewModel
    @State var size: CGSize = .zero
    
    var body: some View {
        ScrollView {
            
            VStack{
            }
            .frame(height: 32)
            
            SettingsViewItem()
                .padding(.bottom, 48)
            
            SettingsViewItem2()
                .padding(.bottom, 48)
            
            SettingsViewItem3(){
                authViewModel.logout()
            }
                .padding(.bottom, 48)
        }
        .background(Color(hex: "A4D8F5"))
    }
}

#Preview {
    SettingsVIew(authViewModel: AuthViewModel())
}

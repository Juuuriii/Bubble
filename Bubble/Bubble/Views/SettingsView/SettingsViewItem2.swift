//
//  SettingsViewItem2.swift
//  Bubble
//
//  Created by Juri Huhn on 19.09.24.
//

import SwiftUI



struct SettingsViewItem2: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    @State private var size: CGSize = .zero
    
    
    var body: some View {
        VStack{
                Image("settingsRect2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay{
                        VStack{
                            HStack{
                                VStack{
                                    Text("PREFERENCES")
                                        .foregroundStyle(Color(hex: "14135B"))
                                        .font(.title2)
                                        .frame(minWidth: 220)
                                    Text("Streamline how to use Bubble")
                                        .foregroundStyle(Color(hex: "14135B"))
                                        .font(.footnote)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(
                                    GeometryReader{proxy in
                                        Capsule()
                                            .foregroundStyle(Color(hex: "84C6EB"))
                                            .onAppear{
                                                size = proxy.size
                                            }
                                    }
                                )
                                Spacer()
                            }
                            .offset(y: -size.height*0.5)
                            
                            VStack(spacing: 16) {
                                HStack {
                                    Text("Quick Add Amount")
                                        .frame(minWidth: 150)
                                        .foregroundStyle(.white)
                                    Spacer()
                                        .frame(width: 40)
                                    Picker("Quick Add Amount", selection: $viewModel.quickAddAmount){
                                        ForEach(QuickAddAmount.allCases, id: \.self){ amount in
                                            Text(amount.display)
                                                .tag(amount)
                                        }
                                    }
                                    .tint(Color(hex: "14135B"))
                                    .frame(minWidth: 100)
                                    .background{
                                        Capsule()
                                            .foregroundStyle(.white)
                                    }
                                    .onChange(of: viewModel.quickAddAmount){
                                        viewModel.updateQuickAddAmount()
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 11)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .background{
                                    Capsule()
                                        .foregroundStyle(Color(hex: "84C6EB"))
                                }
                                
                                
                                
                                HStack {
                                    Text("Currency")
                                        .frame(minWidth: 150)
                                        .foregroundStyle(.white)
                                    Spacer()
                                        .frame(width: 40)
                                    Picker("Currency", selection: $viewModel.currency){
                                        ForEach(AppCurrency.allCases, id: \.self){ currency in
                                            Text(currency.rawValue)
                                                .tag(currency)
                                        }
                                    }
                                    .tint(Color(hex: "14135B"))
                                    .frame(minWidth: 100)
                                    .background{
                                        Capsule()
                                            .foregroundStyle(.white)
                                    }
                                    .onChange(of: viewModel.currency) {
                                        viewModel.updateCurrency()
                                    }
                                    
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 11)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .background{
                                    Capsule()
                                        .foregroundStyle(Color(hex: "84C6EB"))
                                }
                            }
                            .offset(y: -size.height*0.2)
                            .padding(.horizontal)
                            Spacer()
                        }
                    }
        }
        .padding(.horizontal)
    }
}

#Preview {
    SettingsViewItem2(viewModel: SettingsViewModel())
}

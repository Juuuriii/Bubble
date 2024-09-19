//
//  SettingsViewItem2.swift
//  Bubble
//
//  Created by Juri Huhn on 19.09.24.
//

import SwiftUI

struct SettingsViewItem2: View {
    
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
                                    Text("Preferences")
                                        .font(.title2)
                                        .frame(minWidth: 220)
                                    Text("Streamline how to use Bubble")
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
                                Button{
                                    
                                } label: {
                                    Text("Quick Add Amount")
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                        .padding()
                                        .background{
                                            Capsule()
                                                .foregroundStyle(Color(hex: "84C6EB"))
                                        }
                                    
                                }
                                HStack{
                                    Text("Currency")
                                    
                                    
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
    SettingsViewItem2()
}

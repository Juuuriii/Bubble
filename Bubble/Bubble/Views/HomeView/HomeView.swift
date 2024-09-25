//
//  HomeView.swift
//  Bubble
//
//  Created by Juri Huhn on 13.09.24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var sizeHeader: CGSize = .zero
    @State private var sizeAchievements: CGSize = .zero

    var body: some View {
        
        ScrollView{
            VStack{
                Text("\(viewModel.quote.first?.quote ?? "")")
                    .padding()
            }
            .padding(.bottom, 40)
            
            
            
            VStack() {
                HStack{
                    VStack{
                        Text("ACHIEVEMENTS")
                            .foregroundStyle(Color(hex: "14135B"))
                            .font(.title2)
                            .frame(minWidth: 220)
                        Text("Check out your Progress")
                            .foregroundStyle(Color(hex: "14135B"))
                            .font(.footnote)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background{
                        GeometryReader {proxy in
                            Capsule()
                                .foregroundStyle(Color(hex: "84C6EB"))
                                .onAppear{
                                    sizeHeader = proxy.size
                                }
                        }
                    }
                    Spacer()
                }
                .padding(.top, -sizeHeader.height*0.5)
                .padding(.bottom)
                
                HStack{
                    ZStack{
                        Image("cupFinished")
                            .overlay{
                                GeometryReader{proxy in
                                    VStack(alignment: .center){
                                        Text("\(viewModel.finishedSavingGoals)")
                                            .foregroundStyle(.white)
                                            .bold()
                                            .font(.title2)
                                    }
                                    .frame(minWidth: 30)                                        
                                    .offset(x: proxy.size.width*0.28, y: proxy.size.height*0.28)
                                }
                            }
                    }
                    
                    VStack{
                        Text("FINISHED")
                            .foregroundStyle(Color(hex: "14135B"))
                        Text("Saving Goals")
                            .foregroundStyle(Color(hex: "14135B"))
                    }
                    
                }
                
                
                HStack{
                   
                    Image("cupUnfinished")
                        .overlay{
                            GeometryReader{proxy in
                                VStack(alignment: .center){
                                    Text("\(viewModel.savingGoalsAmount)")
                                        .foregroundStyle(.white)
                                        .bold()
                                        .font(.title2)
                                }
                                .frame(minWidth: 30)
                                .offset(x: proxy.size.width*0.6, y: proxy.size.height*0.22)
                            }
                        }
                        
                    VStack{
                        Text("ONGOING")
                            .foregroundStyle(Color(hex: "14135B"))
                        Text("Saving Goals")
                            .foregroundStyle(Color(hex: "14135B"))
                    }
                    .padding(.trailing, sizeAchievements.width*0.14)
                }
                
                Button {
                    
                } label: {
                    HStack{
                        Text("Go to Achievements")
                        Image(systemName: "chevron.forward")
                    }
                }
                .tint(Color(hex: "14135B"))
                .padding()
                .padding(.bottom)
                
                
            }
            .padding(.horizontal)
            .padding(.bottom)
            .frame(maxWidth: .infinity)
            .background {
                GeometryReader{proxy in
                    AchievementBackgroundShape()
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .onAppear{
                            sizeAchievements = proxy.size
                        }
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "A4D8F5"))
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}

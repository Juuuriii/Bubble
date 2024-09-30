//
//  HomeView.swift
//  Bubble
//
//  Created by Juri Huhn on 13.09.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    @State private var sizeHeader: CGSize = .zero
    @State private var sizeAchievements: CGSize = .zero
    @Binding var screen: TabScreen

    var body: some View {
        NavigationStack{
            ScrollView{
                ApiQuoteCard(quote: viewModel.quote.first?.quote ?? "", author: viewModel.quote.first?.author ?? "")
                    .padding(.vertical, 48)
                
                VStack() {
                    CapsuleHeader(title: "Achievements", description: "Check out your Progress", offsetPercent: 0.0)
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
                                .foregroundStyle(BubbleColors.darkBlue)
                            Text("Saving Goals")
                                .foregroundStyle(BubbleColors.darkBlue)
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
                                .foregroundStyle(BubbleColors.darkBlue)
                            Text("Saving Goals")
                                .foregroundStyle(BubbleColors.darkBlue)
                        }
                        .padding(.trailing, sizeAchievements.width*0.19)
                    }
                    
                    
                    Button{
                        withAnimation {
                            screen = .achievement
                        }
                    } label: {
                        Text("Check out Progress")
                        Image(systemName: "chevron.right")
                       
                    }
                    .tint(BubbleColors.darkBlue)
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
            .background(BubbleColors.bgBlue)
        }
    }
}

#Preview {
    HomeView(screen: .constant(TabScreen.home))
}

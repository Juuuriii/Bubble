//
//  HomeView.swift
//  Bubble
//
//  Created by Juri Huhn on 13.09.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
   

    var body: some View {
        VStack{
            VStack{
                Text("\(viewModel.quote.first?.quote ?? "")")
                    .padding()
            }
            
            
            
            VStack() {
                
                Text("ACHIEVEMENTS")
                    .font(.title2)
                Text("Check out your Progress")
                    .font(.footnote)
                HStack{
                    ZStack{
                        Image("cupFinished")
                            .overlay{
                                GeometryReader{proxy in
                                    VStack(alignment: .center){
                                        Text("72")
                                            .foregroundStyle(.white)
                                            .bold()
                                            .font(.title2)
                                    }
                                    .frame(minWidth: 30)                                        .offset(x: proxy.size.width*0.28, y: proxy.size.height*0.28)
                                }
                            }
                    }
                    VStack{
                        Text("FINISHED")
                        Text("Saving Goals")
                    }
                }
                
                
                HStack{
                    Image("cupUnfinished")
                        .overlay{
                            GeometryReader{proxy in
                                VStack(alignment: .center){
                                    Text("72")
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
                        Text("Saving Goals")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "A4D8F5"))
    }
}

#Preview {
    HomeView()
}

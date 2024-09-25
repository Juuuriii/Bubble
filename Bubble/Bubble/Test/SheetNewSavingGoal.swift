//
//  SheetNewSavingGoal.swift
//  Bubble
//
//  Created by Juri Huhn on 25.09.24.
//

import SwiftUI



struct SheetNewSavingGoal: View {
    
    @State var date = Date.now
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(BubbleColor.lightBlue)
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(BubbleColor.midBlue)
                .padding()
                .overlay{
                    VStack(spacing: 24){
                        Text("Saving Goal")
                            .font(.title)
                            .foregroundStyle(BubbleColor.darkBlue)
                            
                        
                        
                        VStack(alignment: .leading){
                            Text("Name of Your Saving Goal")
                                .foregroundStyle(BubbleColor.white)
                            TextField("e.g. Berlin Trip, Overdue Bill", text: .constant(""))
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .background{
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(BubbleColor.white)
                                        
                                }
                        }
                        
                        VStack(alignment: .leading){
                            Text("Type of Savings")
                                .foregroundStyle(BubbleColor.white)
                            TextField("e.g. Family, Personal, Self-Care", text: .constant(""))
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .background{
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(BubbleColor.white)
                                        
                                }
                        }
                        
                        HStack{
                            VStack(alignment: .leading){
                                Text("Target Amount(€)")
                                    .foregroundStyle(BubbleColor.white)
                                TextField("e.g. Family, Personal, Self-Care", text: .constant(""))
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                    .background{
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundStyle(BubbleColor.white)
                                            
                                    }
                            }
                            
                            Spacer()
                                .frame(width: 24)
                            
                            VStack(alignment: .leading){
                                Text("Deadline")
                                    .foregroundStyle(BubbleColor.white)
                                DatePicker("", selection: $date)
                                    
                                    
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical,24)
                    .padding(.horizontal, 32)
                }
            
        }
        .padding()
        .background(BubbleColor.midBlue)
    }
}

#Preview {
    SheetNewSavingGoal()
}

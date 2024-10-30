//
//  MonthReportView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 29/10/24.
//

import SwiftUI
import SwiftData

struct MonthReportView: View {
    var date: Date
    @Environment(\.modelContext) private var modelContext
    
    @State private var isInfoSheetPresented = false
    
    var body: some View {
        ScrollView{
            VStack{
//                HStack{
//                    Text(formattedDate(date, formatter: dateFormatter))
//                        .font(.body)
//                        .opacity(0.5)
//                    
//                    Spacer()
//                    
//                    Button{
//                        print("Raw Photos")
//                    }label: {
//                        Text("Raw Photos")
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.width * 374 / 430)
                
                TabView{
                    ForEach(1..<4){ index in
                        
                        Rectangle()
                            .frame(width: photoSize(), height: photoSize())
                        
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 434 / 932)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                VStack(alignment: .leading){
                    Text("Topograpy Information")
                    
                    Divider()
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.red)
                        Text("Hair")
                    }
                    HStack{
                        Text("●")
                            .foregroundStyle(.yellow)
                        Text("Hair is growing and growing")
                    }
                    HStack{
                        Text("●")
                            .foregroundStyle(.green)
                        Text("Hair is growing")
                    }
                    
                }
                .padding()
                .background(.white)
                .font(.body)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: UIScreen.main.bounds.width * 374 / 430)
                
                TabView{
                    ForEach(1..<4){ index in
                        
                        Rectangle()
                            .frame(width: photoSize(), height: photoSize())
                        
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 434 / 932)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Macro Photo Information")
                        
                        Spacer()
                        
                        Button{
                            print("Raw Photos")
                        }label: {
                            Text("Raw Photos")
                        }
                        
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.red)
                        Text("1 Strand per Follicle")
                    }
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.purple)
                        Text("2 Strand per Follicle")
                    }
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.blue)
                        Text("3 Strand per Follicle")
                    }
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.green)
                        Text("4 Strand per Follicle")
                    }
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.yellow)
                        Text("5 Strand per Follicle")
                    }
                    
                    Text("Average Strands per Follicle: 1,8")
                        .padding(.top)
                }
                .padding()
                .background(.white)
                .font(.body)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: UIScreen.main.bounds.width * 374 / 430)
                
                VStack(alignment: .leading){
                    Text("Last Result & Personal Activities")
                    
                    Divider()
                    
                    VStack(alignment: .center){
                        Text("Your hair growth is")
                            .font(.title2)
                        Text("getting better")
                            .font(.largeTitle)
                    }
                    .frame(width: UIScreen.main.bounds.width * 340 / 430)
                    .padding(.vertical)
                    
                    HStack{
                        Text("·")
                        Text("Have more sleep time")
                    }
                    
                    HStack{
                        Text("·")
                        Text("Reduce your stress")
                    }
                    
                    HStack{
                        Text("·")
                        Text("Start more workouts")
                    }
                    
                    HStack{
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("42")
                                    .font(.title)
                                Text("hrs")
                                    .font(.body)
                            }
                            Text("􀇁 Sleep")
                                .font(.footnote)
                        }
                        .frame(width: UIScreen.main.bounds.width * 111 / 430, height: UIScreen.main.bounds.height * 79 / 932)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 0.5)
                        )
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("100")
                                    .font(.title)
                                Text("pts")
                                    .font(.body)
                            }
                            Text("􀙌 Stress")
                                .font(.footnote)
                        }
                        .frame(width: UIScreen.main.bounds.width * 111 / 430, height: UIScreen.main.bounds.height * 79 / 932)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 0.5)
                        )
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("371")
                                    .font(.title)
                                Text("cal")
                                    .font(.body)
                            }
                            Text("􀜟 Movement")
                                .font(.footnote)
                        }
                        .frame(width: UIScreen.main.bounds.width * 111 / 430, height: UIScreen.main.bounds.height * 79 / 932)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 0.5)
                        )
                    }
                    
                }
                .padding()
                .background(.white)
                .font(.body)
                .frame(width: UIScreen.main.bounds.width * 374 / 430)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                
                Button{
                    print("compare button")
                } label: {
                    Text("Compare Reports")
                        .foregroundStyle(Color("SecondaryColor"))
                }
                .frame(width: UIScreen.main.bounds.width * 374 / 430, height: UIScreen.main.bounds.height * 48 / 932)
                .background(Color("PrimaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            }
            .navigationTitle(formattedDate(date, formatter: dateFormatter))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        isInfoSheetPresented = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
        .background(Color(.systemGray6))
        .sheet(isPresented: $isInfoSheetPresented) {
            InfoSubtractionSheetView(isPresented: $isInfoSheetPresented)
        }
    }
    
    private func  photoSize() -> CGFloat {
        UIScreen.main.bounds.width * 374 / 430
    }
    
    
    private func formattedDate(_ date: Date, formatter: DateFormatter) -> String {
        return formatter.string(from: date)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
}

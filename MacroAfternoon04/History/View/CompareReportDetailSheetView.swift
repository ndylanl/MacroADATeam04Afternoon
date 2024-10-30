//
//  CompareReportDetailSheetView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 29/10/24.
//

import SwiftUI

struct CompareReportDetailSheetView: View {
    
    var selectedReportA: Date?
    var selectedReportB: Date?
    
    @State private var isInfoSheetPresented = false
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    VStack(alignment:.leading){
                        Text("Report A to B")
                            .font(.title2).bold()
                        
                        Text("\(formattedDate(selectedReportA)) - \(formattedDate(selectedReportB))")
                            .font(.body).opacity(0.5)
                    }
                    Spacer()
                }
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
                        Text("Topograpy Information")
                        
                        Spacer()
                        
                        Button{
                            isInfoSheetPresented = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                    
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
                            isInfoSheetPresented = true
                        } label: {
                            Image(systemName: "info.circle")
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
            }
            
            .navigationTitle("Compare Reports")
            .background(Color(.systemGray6).ignoresSafeArea(.all))
        }
        .background(Color(.systemGray6).ignoresSafeArea(.all))
        .sheet(isPresented: $isInfoSheetPresented) {
            InfoSubtractionSheetView(isPresented: $isInfoSheetPresented)
                .background(Color(.systemGray6).ignoresSafeArea(.all))
        }
    }
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    private func photoSize() -> CGFloat {
        UIScreen.main.bounds.width * 374 / 430
    }
}

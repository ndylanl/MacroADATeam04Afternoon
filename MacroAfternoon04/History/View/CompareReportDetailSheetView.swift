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
    @StateObject var viewModel: ComparisonResultViewModel
    
    @State private var isInfoSheetPresented = false
    
    @State private var renderedImage: UIImage?
    
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
                    if viewModel.heatMapArray != [0,0,0,0,0,0,0,0,0,0,0,0]{
                        
                        if let image = renderedImage {
                            Image(uiImage: applyFisheyeEffect(to: image)!)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 454 / 932)
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 434 / 932)
                .tabViewStyle(.page)
                .padding(.bottom, -24)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                VStack(alignment: .leading){
                    Text("Heat Map Information")
                    
                    Divider()
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.red)
                        Text("Hair growth can be better")
                    }
                    HStack{
                        Text("●")
                            .foregroundStyle(.green)
                        Text("Hair is stable")
                    }
                    HStack{
                        Text("●")
                            .foregroundStyle(.blue)
                        Text("Hair is growing")
                    }
                    
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
                        Text(viewModel.hairGrowthStatus)
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
                        Text("·")
                        Text("Be more consistent with applying serum")
                    }
                    .isHidden(viewModel.applySuggestion, remove: viewModel.applySuggestion)
                    
                    HStack{
                        Text("·")
                        Text("Be more consistent with your appointments")
                    }
                    .isHidden(viewModel.appointmentSuggestion, remove: viewModel.appointmentSuggestion)

                    HStack{
                        Text("·")
                        Text("Be more consistent with consuming medication")
                    }
                    .isHidden(viewModel.consumeSuggestion, remove: viewModel.consumeSuggestion)
                    
                    HStack{
                        Text("·")
                        Text("Be more consistent with your exercises")
                    }
                    .isHidden(viewModel.exerciseSuggestion, remove: viewModel.exerciseSuggestion)

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
            }
            
            .navigationTitle("Compare Reports")
            .background(Color(.systemGray6).ignoresSafeArea(.all))
        }
        .background(Color(.systemGray6).ignoresSafeArea(.all))
        .sheet(isPresented: $isInfoSheetPresented) {
            InfoSubtractionSheetView(isPresented: $isInfoSheetPresented)
                .background(Color(.systemGray6).ignoresSafeArea(.all))
        }
        .onAppear{
            let renderer = ImageRenderer(content: HeatmapView(data: createDepthData(originalValues: viewModel.heatMapArray, multiple: 4)))
            renderedImage = renderer.uiImage
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

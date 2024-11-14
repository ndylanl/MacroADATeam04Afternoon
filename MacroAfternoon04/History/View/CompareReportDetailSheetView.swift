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
    @EnvironmentObject var healthViewModel: HealthViewModel
    
    @State private var isInfoSheetPresented = false
    
    @State private var renderedImage: UIImage?
    
    @State var showingSleepAndMovementReport = false
    
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
                            HStack(spacing: 0){
                                HeatMapBar2()
                                Image(uiImage: applyFisheyeEffect(to: image)!)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 454 / 932)
                                    .offset(x: -70)
                            }
                            .padding(.leading, 185)
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 434 / 932)
                .tabViewStyle(.page)
                .padding(.bottom, -24)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Heat Map Information")
                        
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
                    HStack{
                        Text("Last Result & Personal Activites")
                            .font(.body)
                        
                        Spacer()
                        
                        Button{
                            showingSleepAndMovementReport = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                    
                    Divider()
                    
                    VStack(alignment: .center){
                        Text("Your hair growth is")
                            .font(.title2)
                        Text(viewModel.hairGrowthStatus)
                            .font(.largeTitle)
                    }
                    .frame(width: UIScreen.main.bounds.width * 340 / 430)
                    .padding(.vertical)
                    
                    if Int(viewModel.sleepData) ?? 7 <= 6{
                        HStack{
                            Text("·")
                            Text("Have more sleep time")
                        }
                    }
                    
                    if Int(viewModel.movementData) ?? 2001 <= 2000 {
                        HStack{
                            Text("·")
                            Text("Daily workout is recommended")
                        }
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
                                Text(viewModel.sleepData)
                                    .font(.title)
                                Text("hrs")
                                    .font(.body)
                            }
                            HStack{
                                Image(systemName: "moon.stars.fill")
                                Text("Sleep")
                            }
                            .font(.footnote)
                        }
                        .frame(width: UIScreen.main.bounds.width * 374 / 430 / 2 - 20, height: UIScreen.main.bounds.height * 79 / 932)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 0.5)
                        )
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text(viewModel.movementData)
                                    .font(.title)
                                Text("cal")
                                    .font(.body)
                            }
                            HStack{
                                Image(systemName: "waveform.path.ecg")
                                Text("Movement")
                            }
                            .font(.footnote)
                        }
                        .frame(width: UIScreen.main.bounds.width * 374 / 430 / 2 - 20, height: UIScreen.main.bounds.height * 79 / 932)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 0.5)
                        )
                    }
                    
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
        .sheet(isPresented: $showingSleepAndMovementReport, content: {
            InfoSleepAndMovementSheetView(isPresented: $showingSleepAndMovementReport)
        })
        .onAppear{
            viewModel.fetchData(dateReportA: selectedReportA, dateReportB: selectedReportB)
            let renderer = ImageRenderer(content: HeatmapView(data: createDepthData(originalValues: viewModel.heatMapArray, multiple: 4)))
            renderedImage = renderer.uiImage
            viewModel.setPersonalActivity(dateA: selectedReportA!, dateB: selectedReportB!, healthViewModel: healthViewModel)
            
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

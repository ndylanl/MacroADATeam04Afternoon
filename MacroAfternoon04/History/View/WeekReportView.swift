//
//  WeekReportView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 28/10/24.
//

import SwiftUI
import SwiftData

struct WeekReportView: View {
    var date: Date
    @Environment(\.modelContext) private var modelContext
    
    @State private var isInfoSheetPresented = false
    
    @State private var isComparePresented: Bool = false
    
    @StateObject var viewModel: WeeklyReportViewModel
    
    @EnvironmentObject var healthViewModel: HealthViewModel

    @State private var renderedImage: UIImage?
    
    @State var isOnBoardingReportCompleted = UserDefaults.standard.bool(forKey: "onBoardingReportCompleted")
    @State var showingSleepAndMovementReport = false
    
    let labelColors: [Int: Color] = [
        1: .red,
        2: .purple,
        3: .blue,
        4: .green,
        5: .yellow,
        6: .black
    ]
    
    var body: some View {
        if isOnBoardingReportCompleted{
            ScrollView{
                VStack{
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
                        .frame(width: UIScreen.main.bounds.width *  374 / 430 / 2 - 20, height: UIScreen.main.bounds.height * 79 / 932)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 0.5)
                        )
                        
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
                        .padding()
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
                
                Button{
                    isComparePresented = true
                } label: {
                    Text("Compare Reports")
                        .foregroundStyle(Color("SecondaryColor"))
                }
                .frame(width: UIScreen.main.bounds.width * 374 / 430, height: UIScreen.main.bounds.height * 48 / 932)
                .background(Color("PrimaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            }
            .navigationTitle("Week \(convertToRoman(weekOfMonth(for: date)))")
        }
        .background(Color(.systemGray6))
        .onAppear {
            viewModel.weekNumber = weekOfMonth(for: date)
            viewModel.fetchData(weekDate: date)
            healthViewModel.fetchHealthData()
            viewModel.setPersonalActivity(date: date, healthViewModel: healthViewModel)
        }
        .sheet(isPresented: $isInfoSheetPresented) {
            InfoSubtractionSheetView(isPresented: $isInfoSheetPresented)
        }
        .sheet(isPresented: $isComparePresented){
            CompareReportSheetView(viewModel: CompareReportViewModel(modelContext: modelContext))
                .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
        .sheet(isPresented: $showingSleepAndMovementReport, content: {
            InfoSleepAndMovementSheetView(isPresented: $showingSleepAndMovementReport)
        })
    }
    
    func photoSize() -> CGFloat {
        UIScreen.main.bounds.width * 374 / 430
    }
    
    private func formattedDate(_ date: Date, formatter: DateFormatter) -> String {
        return formatter.string(from: date)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    private func weekOfMonth(for date: Date) -> Int {
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
        return weekOfMonth
    }

    func convertToRoman(_ number: Int) -> String {
        let romanValues = [
            1000: "M", 900: "CM", 500: "D", 400: "CD",
            100: "C", 90: "XC", 50: "L", 40: "XL",
            10: "X", 9: "IX", 5: "V", 4: "IV", 1: "I"
        ]
        
        var num = number
        var result = ""
        
        for (value, numeral) in romanValues.sorted(by: { $0.key > $1.key }) {
            while num >= value {
                result += numeral
                num -= value
            }
        }
        
        return result
    }

}

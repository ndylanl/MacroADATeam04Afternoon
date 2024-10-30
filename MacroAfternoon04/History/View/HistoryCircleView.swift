//
//  HistoryCircleView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 28/10/24.
//

import SwiftUI

struct HistoryCircleView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var historyViewModel: HistoryViewModel?
    @State private var selectedMonthYear: Date?
    @State private var showPicker = false
    @State private var weeksData: [Date] = []
    
    @State private var isComparePresented: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Button{
                        showPicker.toggle()
                    } label: {
                        Text(selectedMonthYear != nil ? formattedDate(selectedMonthYear!, formatter: monthYearFormatter) : "Select Month and Year")
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.vertical, 12)
                            .padding(.horizontal, 8)
                            .background(Color("SecondaryColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(width: UIScreen.main.bounds.width * 374 / 430, height: 50, alignment: .leading)
                    
                    if historyViewModel != nil {
                        
                        VStack {
                            if let selectedMonthYear = selectedMonthYear {
                                ZStack {
                                    NavigationLink{
                                        MonthReportView(date: selectedMonthYear)
                                    } label: {
                                        MonthCircleView(nameOfTheMonth: formattedDate(selectedMonthYear, formatter: monthFormatter))
                                            .padding()
                                    }

                                    ForEach(weeksData, id: \.self) { weekDate in
                                        NavigationLink {
                                            WeekReportView(date: weekDate)
                                        } label: {
                                            WeekCircleView(weekDate: weekDate)
                                                .padding()
                                        }
                                        .offset(x: circleOffset(for: weekDate).x, y: circleOffset(for: weekDate).y)
                                    }
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 370 / 932)
                        
                    }
                    
                    VStack{
                        Button{
                            isComparePresented = true
                        } label: {
                            Text("Compare Reports")
                                .frame(width: UIScreen.main.bounds.width * 374 / 430, height: UIScreen.main.bounds.height * 48 / 932)
                        }
                        
                        .background(Color("PrimaryColor"))
                        .foregroundStyle(Color("SecondaryColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
                        
                        Button{
                            print("all data")
                        } label: {
                            Text("Browse All Data")
                        }
                        .foregroundStyle(Color("PrimaryColor"))
                        .padding(.top)
                    }
                }
                .navigationTitle(" History")
            }
            
            .onAppear {
                if historyViewModel == nil {
                    historyViewModel = HistoryViewModel(modelContext: modelContext)
                    if let latestMonth = historyViewModel?.uniqueMonths.first {
                        selectedMonthYear = latestMonth
                    }
                }
                updateWeeksData()
            }
            
            .onChange(of: selectedMonthYear) { oldValue, newValue in
                updateWeeksData()
            }
        }
        .sheet(isPresented: $showPicker) {
            VStack {
                if let historyViewModel = historyViewModel {
                    Picker("Select Month and Year", selection: $selectedMonthYear) {
                        ForEach(historyViewModel.uniqueMonths, id: \.self) { date in
                            Text(formattedDate(date, formatter: monthYearFormatter)).tag(date as Date?)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                }
                Button("Done") {
                    showPicker.toggle()
                }
                .padding()
            }
        }
        .sheet(isPresented: $isComparePresented){
            CompareReportSheetView(viewModel: CompareReportViewModel(modelContext: modelContext))
                .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
    
    private func updateWeeksData() {
        if let selectedMonthYear = selectedMonthYear, let historyViewModel = historyViewModel {
            weeksData = historyViewModel.trackProgress
                .filter { Calendar.current.isDate($0.dateTaken, equalTo: selectedMonthYear, toGranularity: .month) }
                .map { $0.dateTaken }
        }
    }
    
    private func formattedDate(_ date: Date, formatter: DateFormatter) -> String {
        return formatter.string(from: date)
    }
    
    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    private var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    private func circleOffset(for weekDate: Date) -> (x: CGFloat, y: CGFloat) {
        guard let index = weeksData.firstIndex(of: weekDate) else { return (x: 0, y: 0) }
        let angle = Double(index) * (180.0 / Double(weeksData.count)) - 70.0
        let radius = UIScreen.main.bounds.width * 0.3
        let x = radius * cos(angle * .pi / 150)
        let y = radius * sin(angle * .pi / 150)
        return (x: x, y: y)
    }
}

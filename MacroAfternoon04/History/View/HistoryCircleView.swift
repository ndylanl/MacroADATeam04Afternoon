//
//  HistoryCircleView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 28/10/24.
//

import SwiftUI
import SwiftData

struct HistoryCircleView: View {
    @Environment(\.modelContext) var modelContext
    
    @StateObject private var historyViewModel: HistoryViewModel
    
    @State private var selectedMonthYear: Date?
    @State private var showPicker = false
    @State private var weeksData: [Date] = []
    
    @State private var isComparePresented: Bool = false
    @State private var isAnimating = false
    
    @State  var showAlert = false
    @State  var alertMessage: String = ""
    @State private var navigateToMonthReport = false

    
    public init(modelContext: ModelContext) {
        _historyViewModel = StateObject(wrappedValue: HistoryViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if !historyViewModel.trackProgress.isEmpty {
                        monthYearPickerButton
                        monthYearCircleView
                        actionButtons
                    } else {
                        emptyView
                    }
                }
                .navigationTitle("History")
            }
            .onAppear {
                historyViewModel.fetchTrackProgress()
                if let latestMonth = historyViewModel.uniqueMonths.first {
                    selectedMonthYear = latestMonth
                }
                updateWeeksData()
            }
            .onChange(of: selectedMonthYear) { _, _ in
                updateWeeksData()
            }
        }
        .sheet(isPresented: $showPicker) {
            monthYearPickerSheet
                .presentationDetents([.fraction(0.2)])
        }
        .sheet(isPresented: $isComparePresented) {
            CompareReportSheetView(viewModel: CompareReportViewModel(modelContext: modelContext))
                .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
    
    private var monthYearPickerButton: some View {
        Button {
            showPicker.toggle()
//        Menu {
//            VStack {
//                Picker("Select Month and Year", selection: $selectedMonthYear) {
//                    ForEach(historyViewModel.uniqueMonths, id: \.self) { date in
//                        Text(formattedDate(date, formatter: monthYearFormatter)).tag(date as Date?)
//                    }
//                }
////                .pickerStyle(WheelPickerStyle())
////                .labelsHidden()
//                .pickerStyle(.menu)
//            }
        } label: {
            Text(selectedMonthYear != nil ? formattedDate(selectedMonthYear!, formatter: monthYearFormatter) : "Select Month and Year")
                .foregroundColor(Color("PrimaryColor"))
                .padding(.vertical, 12)
                .padding(.horizontal, 8)
                .background(Color("SecondaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .frame(width:UIScreen.main.bounds.width - 24, height: 50, alignment: .leading)
        .padding(.horizontal)
    }
    
    private var monthYearCircleView: some View {
        
        
        VStack {
            if let selectedMonthYear = selectedMonthYear {
                ZStack {
                    Button(action: {
                        // Set the alert message if needed
                        alertMessage = "The Monthly Report will be available at the end of the month."
                        showAlert = MonthlyReportViewModel(modelContext: modelContext, selectedMonthYear: selectedMonthYear).checkMonthlyReportAccess(date: selectedMonthYear)
                        
                        if !showAlert{
                            navigateToMonthReport = true
                        }
                    }) {
                        MonthCircleView(nameOfTheMonth: formattedDate(selectedMonthYear, formatter: monthFormatter))
                            .padding()
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Monthly Report Status"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK")) {
                            }
                        )
                    }
                    
                    NavigationLink(destination: MonthReportView(date: selectedMonthYear, viewModel: MonthlyReportViewModel(modelContext: modelContext, selectedMonthYear: selectedMonthYear)), isActive: $navigateToMonthReport) {
                        EmptyView() // This is needed to create a link without visible content
                    }
                    
                    ForEach(weeksData, id: \.self) { weekDate in
                        NavigationLink {
                            WeekReportView(date: weekDate, viewModel: WeeklyReportViewModel(modelContext: modelContext, weekDate: weekDate))
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
    
    private var actionButtons: some View {
        VStack {
            Button {
                isComparePresented = true
            } label: {
                Text("Compare Reports")
                    .frame(width: UIScreen.main.bounds.width * 374 / 430, height: UIScreen.main.bounds.height * 48 / 932)
            }
            .background(Color("PrimaryColor"))
            .foregroundStyle(Color("SecondaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
            
            NavigationLink {
                BrowseAllDataView(modelContext: modelContext)
            } label: {
                Text("Browse All Data")
            }
            .foregroundStyle(Color("PrimaryColor"))
            .padding(.top)
        }
    }
    
    private var emptyView: some View {
        VStack {
            Image("EmptyViewHistory")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 234 / 430, height: UIScreen.main.bounds.height * 264 / 932)
        }
        .padding(.top, 188)
    }
    
    private var monthYearPickerSheet: some View {
        NavigationView{
            VStack {
                Picker("Select Month and Year", selection: $selectedMonthYear) {
                    ForEach(historyViewModel.uniqueMonths, id: \.self) { date in
                        Text(formattedDate(date, formatter: monthYearFormatter)).tag(date as Date?)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Done") {
                        showPicker.toggle()
                    }
                }
            }
        }
        .interactiveDismissDisabled()
    }
    
    private func updateWeeksData() {
        if let selectedMonthYear = selectedMonthYear {
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

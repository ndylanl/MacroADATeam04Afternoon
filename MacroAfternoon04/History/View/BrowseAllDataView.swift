//
//  BrowseAllDataView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 07/11/24.
//

import SwiftUI
import SwiftData

struct BrowseAllDataView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State  var showAlert = false
    @State  var alertMessage: String = ""
    @State private var navigateToMonthReport = false
    
    @StateObject private var historyViewModel: HistoryViewModel
    
    public init(modelContext: ModelContext) {
        _historyViewModel = StateObject(wrappedValue: HistoryViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        List {
            ForEach(historyViewModel.uniqueMonths, id: \.self) { month in
                Section(header: Text(formattedDate(month, formatter: monthYearFormatter))) {
                    
                    
                    if MonthlyReportViewModel(modelContext: modelContext, selectedMonthYear: month).checkMonthlyReportAccess(date: month){
                        Button(action: {
                            // Set the alert message if needed
                            alertMessage = "The Monthly Report will be available at the end of the month."
                            showAlert = MonthlyReportViewModel(modelContext: modelContext, selectedMonthYear: month).checkMonthlyReportAccess(date: month)
                            
                            if !showAlert{
                                navigateToMonthReport = true
                            }
                        }) {
                            VStack(alignment: .leading) {
                                Text("Monthly Report")
                                    .bold()
                                Text(formattedDate(endOfMonth(for: month), formatter: dayMonthYearFormatter))
                                    .font(.caption)
                                    .foregroundStyle(Color("NeutralColor"))
                            }
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Monthly Report Status"),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("OK")) {
                                }
                            )
                        }
                        
                        NavigationLink(destination: MonthReportView(date: month, viewModel: MonthlyReportViewModel(modelContext: modelContext, selectedMonthYear: month)), isActive: $navigateToMonthReport) {
                            EmptyView() // This is needed to create a link without visible content
                        }
                        .isHidden(true, remove: true)
                    }else{
                        NavigationLink(destination: MonthReportView(date: month, viewModel: MonthlyReportViewModel(modelContext: modelContext, selectedMonthYear: month))) {
                            VStack(alignment: .leading) {
                                Text("Monthly Report")
                                    .bold()
                                Text(formattedDate(endOfMonth(for: month), formatter: dayMonthYearFormatter))
                                    .font(.caption)
                                    .foregroundStyle(Color("NeutralColor"))
                            }
                        }
                    }

                    ForEach(weeksInMonth(month), id: \.self) { weekDate in
                        NavigationLink(destination: WeekReportView(date: weekDate, viewModel: WeeklyReportViewModel(modelContext: modelContext, weekDate: weekDate))) {
                            VStack(alignment: .leading) {
                                Text("Week \(weekOfMonth(for: weekDate)) Report")
                                Text(formattedDate(weekDate, formatter: dayMonthYearFormatter))
                                    .font(.caption)
                                    .foregroundStyle(Color("NeutralColor"))
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Browse All Data")
        .onAppear {
            historyViewModel.fetchTrackProgress()
        }
        
    }
    
    private func weeksInMonth(_ month: Date) -> [Date] {
        historyViewModel.trackProgress
            .filter { Calendar.current.isDate($0.dateTaken, equalTo: month, toGranularity: .month) }
            .map { $0.dateTaken }
    }
    
    private func formattedDate(_ date: Date, formatter: DateFormatter) -> String {
        return formatter.string(from: date)
    }
    
    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    private var dayMonthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    private func weekOfMonth(for date: Date) -> Int {
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
        return weekOfMonth
    }
    
    private func endOfMonth(for date: Date) -> Date {
        let calendar = Calendar.current
        let components = DateComponents(month: 1, day: -1)
        return calendar.date(byAdding: components, to: calendar.date(from: calendar.dateComponents([.year, .month], from: date))!)!
    }
}

//#Preview {
//    BrowseAllDataView(modelContext: ModelContext())
//}

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
    
    @StateObject private var historyViewModel: HistoryViewModel
    
    public init(modelContext: ModelContext) {
        _historyViewModel = StateObject(wrappedValue: HistoryViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        List {
            ForEach(historyViewModel.uniqueMonths, id: \.self) { month in
                Section(header: Text(formattedDate(month, formatter: monthYearFormatter))) {
                    NavigationLink(destination: MonthReportView(date: month)) {
                        Text("Monthly Report")
                            .bold()
                    }
                    
                    ForEach(weeksInMonth(month), id: \.self) { weekDate in
                        NavigationLink(destination: WeekReportView(date: weekDate, viewModel: WeeklyReportViewModel(modelContext: modelContext, weekDate: weekDate))) {
                            Text("Week \(weekOfMonth(for: weekDate)) Report")
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
    
    private func weekOfMonth(for date: Date) -> Int {
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
        return weekOfMonth
    }
}

//#Preview {
//    BrowseAllDataView(modelContext: ModelContext())
//}

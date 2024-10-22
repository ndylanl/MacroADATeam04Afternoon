//
//  CompareReportsView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 17/10/24.
//

import SwiftUI

struct CompareReportsView: View {
    @State private var isComparing: Bool = false  // Toggle between selection and comparison
    @State private var selectedReportA: Int = 1  // Store selected report A (week number)
    @State private var selectedReportB: Int = 1  // Store selected report B (week number)
    
    @Environment(\.presentationMode) var presentationMode  // To dismiss the view
    @Environment(\.modelContext) var modelContext  // Environment context
    
    @StateObject private var viewModel: CompareProgressViewModel // ViewModel for comparison data
    //var reports: [Int]  // List of available reports (week numbers)
    
    init(viewModel: CompareProgressViewModel/*, reports: [Int]*/) {
        _viewModel = StateObject(wrappedValue: viewModel)
        //self.reports = reports
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !isComparing {
                    DateSelectionView(
                        selectedReportA: $selectedReportA,
                        selectedReportB: $selectedReportB,
                        compareAction: {
                            // Action when the compare button is pressed
                            isComparing.toggle()
                        }/*, reports: reports*/
                    )
                    let _ = print("Compare Report A: \(selectedReportA), Report B: \(selectedReportB)\n")
                } else /*if let reportA = selectedReportA, let reportB = selectedReportB*/ {
                    // Convert week numbers to dates for comparison
//                    let dateA = convertWeekToDate(week: reportA)
//                    let dateB = convertWeekToDate(week: reportB)
                    //let _ = print("Report A: \(reportA), Report B: \(reportB)\n")
                    ComparisonResultView(
                        /*viewModel: viewModel,*/
                        reportA: selectedReportA,
                        reportB: selectedReportB
                    )
                }
            }
            .navigationBarTitle("Compare Reports", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    if isComparing {
                        isComparing = false  // Go back to report selection
                    } else {
                        presentationMode.wrappedValue.dismiss()  // Cancel and dismiss
                    }
                }) {
                    Text(isComparing ? "Back" : "Cancel")
                },
                trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()  // Done action
                }) {
                    Text("Done")
                }
                .opacity(isComparing ? 1 : 0)  // Show 'Done' only if in comparing mode
            )
            .onAppear {
                viewModel.modelContext = modelContext  // Set model context when view appears
                viewModel.fetchProgressData()  // Fetch data for comparison
            }
        }
    }
    
    // Convert week number to Date (Assuming the first week starts on a specific date)
    private func convertWeekToDate(week: Int) -> Date {
        // Define the start date of the first week, e.g., January 1, 2024
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
        
        // Calculate the date corresponding to the week number
        let date = calendar.date(byAdding: .weekOfYear, value: week - 1, to: startDate)!
        return date
    }
}



//struct CompareReportsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompareReportsView()
//    }
//}

//
//  CompareReportSheetView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 29/10/24.
//

import SwiftUI

struct CompareReportSheetView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel: CompareReportViewModel
    
    init(viewModel: CompareReportViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    
                    Text("Report A")
                        .font(.title2).bold()
                        .padding()
                    SelectDateView(selectedReport: $viewModel.selectedReportA, availableDates: viewModel.availableDates)
                        .padding()
                    
                    Text("Report B")
                        .font(.title2).bold()
                        .padding()
                    
                    SelectDateView(selectedReport: $viewModel.selectedReportB, availableDates: viewModel.availableDates)
                        .padding()
                    
                    NavigationLink {
                        CompareReportDetailSheetView(selectedReportA: viewModel.selectedReportA, selectedReportB: viewModel.selectedReportB)
                    } label: {
                        Text("Compare")
                            .font(.headline)
                            .foregroundColor(Color("SecondaryColor"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(12)
                            .padding()
                    }
                    .padding()
                    .disabled((viewModel.selectedReportA == nil) && (viewModel.selectedReportB == nil))
                }
            }
            .background(Color(.systemGray6))
            .navigationTitle("Compare Reports")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct SelectDateView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var selectedReport: Date?
    
    @State private var historyViewModel: HistoryViewModel?
    
    var availableDates: [Date]
    
    var body: some View {
        
        VStack{
            Picker("Select Report", selection: $selectedReport) {
                ForEach(availableDates, id: \.self) { date in
                    Text(formattedDate(date, formatter: selectedDateFormat)).tag(date as Date?)
                }
            }
            //            .background(Color.white)
            .pickerStyle(WheelPickerStyle())
            .frame(width: UIScreen.main.bounds.width * 297 / 430)
//            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(width: UIScreen.main.bounds.width * 374 / 430)
        
        
    }
    
    private func formattedDate(_ date: Date, formatter: DateFormatter) -> String {
        return formatter.string(from: date)
    }
    
    private var selectedDateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }
}

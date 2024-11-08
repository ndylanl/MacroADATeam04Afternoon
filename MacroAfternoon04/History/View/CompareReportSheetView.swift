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
    
    @State  var showAlert = false
    @State  var alertMessage: String = ""
    @State private var navigateToReport = false
    
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
                    
                    //                    NavigationLink {
                    //                        CompareReportDetailSheetView(selectedReportA: viewModel.selectedReportA, selectedReportB: viewModel.selectedReportB, viewModel: ComparisonResultViewModel(modelContext: modelContext, dateReportA: viewModel.selectedReportA, dateReportB: viewModel.selectedReportB))
                    //                    } label: {
                    //                        Text("Compare")
                    //                            .font(.headline)
                    //                            .foregroundColor(Color("SecondaryColor"))
                    //                            .padding()
                    //                            .frame(maxWidth: .infinity)
                    //                            .background(Color("PrimaryColor"))
                    //                            .cornerRadius(12)
                    //                            .padding()
                    //                    }
                    //                    .padding()
                    //                    .disabled((viewModel.selectedReportA == nil) && (viewModel.selectedReportB == nil))
                    
                    ZStack {
                        Button(action: {
                            // Set the alert message if needed
                            alertMessage = "You will not be able to access the report comparison due to difference of scalp area."
                            showAlert = ComparisonResultViewModel(modelContext: modelContext, dateReportA: viewModel.selectedReportA, dateReportB: viewModel.selectedReportB).checkReportAccess(dateReportA: viewModel.selectedReportA, dateReportB: viewModel.selectedReportB)
                            
                            if !showAlert{
                                navigateToReport = true
                            }
                        }) {
                            Text("Compare")
                                .font(.headline)
                                .foregroundColor(Color("SecondaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("PrimaryColor"))
                                .cornerRadius(12)
                                .padding()
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Compare Report Status"),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("OK")) {
                                }
                            )
                        }
                        .disabled((viewModel.selectedReportA == nil) && (viewModel.selectedReportB == nil))
                        
                        
                        NavigationLink(destination: CompareReportDetailSheetView(selectedReportA: viewModel.selectedReportA, selectedReportB: viewModel.selectedReportB, viewModel: ComparisonResultViewModel(modelContext: modelContext, dateReportA: viewModel.selectedReportA, dateReportB: viewModel.selectedReportB)), isActive: $navigateToReport) {
                            EmptyView() // This is needed to create a link without visible content
                        }
                        
                        
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
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
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
}

////
////  HistoryView.swift
////  MacroAfternoon04
////
////  Created by Nicholas Dylan Lienardi on 08/10/24.
////
//
//import SwiftUI
//
//struct HistoryView: View {
//    @Environment(\.modelContext) private var modelContext
//    
//    @State private var selectedDate = Date()
//    @State private var showPicker = false
//    @State var weeklyReportViewModel: WeeklyReportViewModel?
//    
//    var body: some View {
//        NavigationView{
//            VStack(alignment: .leading){
//                
//                Button(action: {
//                    showPicker.toggle()
//                }) {
//                    Text("\(selectedDate, formatter: monthYearFormatter)")
//                        .foregroundColor(.blue)
//                        .padding(.vertical, 12)
//                        .padding(.horizontal, 24)
//                        .background(Color(uiColor: .systemGray6))
//                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                }
//                .padding(.horizontal)
//                .frame(height: 50)
//                
//                if weeklyReportViewModel != nil {
//                    List{
//                        ForEach(Array(stride(from: weeklyReportViewModel!.totalWeeks(), through: 1, by: -1)), id: \.self) { i in
//                            NavigationLink(destination: WeeklyReportView(viewModel: WeeklyReportViewModel(weekNumber: i, modelContext: modelContext), weekNumber: i)) {
//                                Text("Week \(i)")
//                            }
//                        }
//                    }
//                    .scrollContentBackground(.hidden)
//                    
//                }
//                
//            }
//            .background(Color.white)
//            .navigationTitle("History")
//        }
//        .task{
//            weeklyReportViewModel =  WeeklyReportViewModel(weekNumber: 1, modelContext: modelContext)
//        }
//        .sheet(isPresented: $showPicker) {
//            VStack {
//                DatePicker(
//                    "Select Date",
//                    selection: $selectedDate,
//                    displayedComponents: [.date]
//                )
//                .datePickerStyle(.wheel)
//                .labelsHidden()
//                Button("Done") {
//                    showPicker.toggle()
//                }
//                .padding()
//            }
//        }
//    }
//    
//    private var monthYearFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter
//    }
//}
//
//

//
//  HistoryCircleView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 28/10/24.
//

//import SwiftUI
//
//struct HistoryCircleView: View {
//    @Environment(\.modelContext) var modelContext
//    
//    @State private var showPicker = false
//    
//    @StateObject var historyViewModel: HistoryViewModel
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                showPicker.toggle()
//            }) {
//                Text(formattedDate(historyViewModel.selectedDate, formatter: monthYearFormatter))
//                    .foregroundColor(.blue)
//                    .padding(.vertical, 12)
//                    .padding(.horizontal, 24)
//                    .background(Color(uiColor: .systemGray6))
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//            }
//            .padding(.horizontal)
//            .frame(height: 50)
//            
//            ZStack {
//                MonthCircleView(nameOfTheMonth: formattedDate(historyViewModel.selectedDate, formatter: monthFormatter))
//                
//                ForEach(historyViewModel.weeksData, id: \.self) { weekDate in
//                    NavigationLink {
//                        // Navigate to Weekly Report
//                    } label: {
//                        WeekCircleView(weekDate: weekDate)
//                    }
//                    .offset(x: circleOffset(for: weekDate).x, y: circleOffset(for: weekDate).y)
//                }
//            }
//        }
//        .sheet(isPresented: $showPicker) {
//            VStack {
//                Picker("Select Month and Year", selection: $historyViewModel.selectedDate) {
//                    ForEach(historyViewModel.availableMonthsAndYears, id: \.self) { date in
//                        Text(formattedDate(date, formatter: monthYearFormatter)).tag(date)
//                    }
//                }
//                .pickerStyle(WheelPickerStyle())
//                .labelsHidden()
//                Button("Done") {
//                    showPicker.toggle()
//                }
//                .padding()
//            }
//        }
//    }
//    
//    private func circleOffset(for weekDate: Date) -> (x: CGFloat, y: CGFloat) {
//        let index = historyViewModel.weeksData.firstIndex(of: weekDate) ?? 0
//        let angle = Double(index) * (360.0 / Double(historyViewModel.weeksData.count))
//        let radius = UIScreen.main.bounds.width * 0.3
//        let x = radius * cos(angle * .pi / 180)
//        let y = radius * sin(angle * .pi / 180)
//        return (x: x, y: y)
//    }
//    
//    private func formattedDate(_ date: Date, formatter: DateFormatter) -> String {
//        return formatter.string(from: date)
//    }
//    
//    private var monthYearFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter
//    }
//    
//    private var monthFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM"
//        return formatter
//    }
//}

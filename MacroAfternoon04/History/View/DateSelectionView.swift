//
//  DateSelectionView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 17/10/24.
//

import SwiftUI

struct DateSelectionView: View {
    @Binding var selectedReportA: Int  // We will store the week number of selected report A
    @Binding var selectedReportB: Int  // We will store the week number of selected report B
    var compareAction: () -> Void
    //var reports: [Int]  // List of reports (week numbers)
    
    @State var weeklyReportViewModel: WeeklyReportViewModel?
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Report A")
                    .font(.title3)
                    .bold()
                
                if weeklyReportViewModel != nil {
                    Picker("Select Report A", selection: $selectedReportA) {
                        //                    ForEach(reports, id: \.self) { report in
                        //                        Text("Week \(report)").tag(report as Int?)
                        //                    }
                        
                        ForEach(1..<weeklyReportViewModel!.totalWeeks() + 1, id: \.self) { i in
                            Text("Week \(i)").tag(i)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding()
                }
            }
            
            VStack(alignment: .leading) {
                Text("Report B")
                    .font(.title3)
                    .bold()
                
                if weeklyReportViewModel != nil {
                    Picker("Select Report B", selection: $selectedReportB) {
                        //                    ForEach(reports, id: \.self) { report in
                        //                        Text("Week \(report)").tag(report as Int?)
                        //                    }
                        ForEach(1..<weeklyReportViewModel!.totalWeeks() + 1, id: \.self) { i in
                            Text("Week \(i)").tag(i)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding()
                }
            }
            
            Button(action: compareAction) {
                Text("Compare")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .task{
            weeklyReportViewModel =  WeeklyReportViewModel(weekNumber: 1, modelContext: modelContext)
        }
    }
}

//struct DateSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        DateSelectionView(selectedReportA: .constant(Date()), selectedReportB: .constant(Date()), compareAction: {})
//    }
//}

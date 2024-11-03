//
//  SettingsSheetView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 01/11/24.
//

import SwiftUI

struct SettingsSheetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedDay: Int
    
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Day", selection: $selectedDay) {
                    ForEach(1..<8) { day in
                        Text(self.dayName(for: day)).tag(day)
                    }
                }
                .pickerStyle(.inline)
                .onChange(of: selectedDay) { beforeValue, afterValue in
                    UserDefaults.standard.set(self.selectedDay, forKey: "selectedDay")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
            .alert("Title", isPresented: $isShowAlert) {
                Button("Delete", role: .destructive) {
                    resetAllData()
                }
            } message: {
                Text("Message")
            }
        }
    }
    
    func resetAllData() {
        
    }
    
    private func dayName(for day: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let date = Calendar.current.date(bySetting: .weekday, value: day, of: Date())!
        return formatter.string(from: date)
    }
}

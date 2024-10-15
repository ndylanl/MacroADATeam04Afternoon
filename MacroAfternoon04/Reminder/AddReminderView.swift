//
//  AddReminderView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 09/10/24.
//

import SwiftUI
import SwiftData
import UserNotifications

struct AddReminderView: View {
    @State var time = Date()                // Stores the selected reminder time
    @State var repeatOption = RepeatOption.never // Default repeat option using `RepeatOption`
    @State var label = "Reminder"
    @State var sound = Sound.defaultSound // Default label for the reminder
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    
    @Query var list: [ReminderModel] // For SwiftData insertion
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .padding(.vertical)
                    
                    Form {
                        Picker("Repeat", selection: $repeatOption) {
                            ForEach(RepeatOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        
                        HStack {
                            Text("Label")
                            Spacer()
                            TextField("Reminder Label", text: $label)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.default)
                                .onTapGesture {
                                    print("TextField tapped")
                                }
                        }
                        
                        Picker("Sound", selection: $sound) {
                            ForEach(Sound.allCases, id: \.self) { soundOption in
                                Text(soundOption.rawValue).tag(soundOption)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                }
                .navigationTitle("Add Reminder")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }, trailing: Button("Save") {
                    // Insert the new reminder model into the SwiftData context
                    let newReminder = ReminderModel(
                        label: label,
                        reminderTime: time,
                        repeatOption: repeatOption,
                        isReminderOn: true,
                        reminderSound: sound
                    )
                    modelContext.insert(newReminder)
                    
                    // Schedule the notification
                    scheduleReminderNotification(for: newReminder)
                    
                    // Dismiss the view
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
    
    // Helper function to schedule the notification
    func scheduleReminderNotification(for reminder: ReminderModel) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: reminder.reminderTime)
        let minute = calendar.component(.minute, from: reminder.reminderTime)
        
        // Call the dispatchNotification function to set the notification
        checkForPermissions(label: reminder.label, id: reminder.id, at: hour, minute: minute)
    }
}

// For preview purposes
#Preview {
    AddReminderView()
}

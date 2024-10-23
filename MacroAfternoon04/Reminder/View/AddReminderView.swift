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
    @Binding var reminder: ReminderModel?    // Binding to handle either a new or existing reminder
    @State var time = Date()                 // Stores the selected reminder time
    @State var repeatOption = RepeatOption.never // Default repeat option using `RepeatOption`
    @State var label = "Reminder"
    @State var sound = Sound.defaultSound    // Default label for the reminder
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var reminderViewModel = ReminderViewModel()
    
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
                        }
                        
                        Picker("Sound", selection: $sound) {
                            ForEach(Sound.allCases, id: \.self) { soundOption in
                                Text(soundOption.rawValue).tag(soundOption)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                }
                .onAppear {
                    if let reminder = reminder {
                        // If an existing reminder is passed, pre-populate the fields
                        time = reminder.reminderTime
                        repeatOption = reminder.repeatOption
                        label = reminder.label
                        sound = reminder.reminderSound
                    }
                }
                .navigationTitle(reminder == nil ? "Add Reminder" : "Edit Reminder") // Show appropriate title
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }, trailing: Button("Save") {
                    if let reminder = reminder {
                        // Update existing reminder
                        reminder.label = label
                        reminder.reminderTime = time
                        reminder.repeatOption = repeatOption
                        reminder.reminderSound = sound
                        
                        // Save the updated reminder in the modelContext
                        reminderViewModel.updateReminder(reminder, isOn: reminder.isReminderOn, context: modelContext)
                    } else {
                        // Insert a new reminder model into the SwiftData context
                        let newReminder = ReminderModel(
                            label: label,
                            reminderTime: time,
                            repeatOption: repeatOption,
                            isReminderOn: true,
                            reminderSound: sound
                        )
                        modelContext.insert(newReminder)
                        
                        // Schedule the notification
                        reminderViewModel.scheduleReminderNotification(for: newReminder)
                    }
                    
                    // Dismiss the view
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
}


// For preview purposes
#Preview {
    AddReminderView(reminder: .constant(nil))
}

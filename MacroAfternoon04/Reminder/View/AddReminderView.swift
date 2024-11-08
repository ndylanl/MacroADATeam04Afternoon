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
    @State var time = Date()
//    @State var repeatOption = RepeatOption.never
    @State var label = ""
    //@State var sound = Sound.defaultSound
    @State var category = ReminderCategory.other
    @State var selectedRepeatOptions: [RepeatOption] = [RepeatOption.never]
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var reminderViewModel = ReminderViewModel()
    
    @Query var list: [ReminderModel] 
    @State var isInitalize = false
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .background(Color(.systemGray6))
                        .labelsHidden()
                        .padding(.vertical)
                    
                    
                    Form {
                        Section{
                            HStack {
                                Text("Label")
                                Spacer()
                                TextField("Example: Put on hair oil", text: $label)
                                    .foregroundColor(label.isEmpty ? Color.gray.opacity(0.6) : Color.black)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.default)
                                    .submitLabel(.done)
                            }
                            
                            Picker("Category", selection: $category) {
                                ForEach(ReminderCategory.allCases, id: \.self) { option in
                                    Text(option.rawValue)
                                        .tag(option)
                                }
                            }
                            .tint(.gray)
                            
                            NavigationLink(destination: {
                                MultiSelectPickerView(selectedItems: $selectedRepeatOptions)
                                    .navigationTitle("Repeat")
                            }) {
                                HStack {
                                    Text("Repeat")
                                    Spacer()
                                    Text(selectedRepeatOptions
                                        .sorted { RepeatOption.allCases.firstIndex(of: $0)! < RepeatOption.allCases.firstIndex(of: $1)! }
                                        .map { $0.rawValue }
                                        .joined(separator: ", "))
                                        .foregroundColor(.gray)
                                    
                                }
                            }
                            
                            
//                            Picker("Repeat", selection: $repeatOption) {
//                                ForEach(RepeatOption.allCases, id: \.self) { option in
//                                    Text(option.rawValue)
//                                        .tag(option)
//                                }
//                            }
//                            .tint(.blue)
                            
//                            Picker("Sound", selection: $sound) {
//                                ForEach(Sound.allCases, id: \.self) { soundOption in
//                                    Text(soundOption.rawValue)
//                                        
//                                        .tag(soundOption)
//                                }
//                            }
//                            .tint(.blue)
                        }
                        .listRowBackground(Color(.white))
                        
                    }
                    //.background(Color(.systemGray6))
                    
                    .background(Color(.systemGray6))
                    .scrollContentBackground(.hidden)
                    
                }
                .background(Color(.systemGray6))
                .onAppear {
                    if let reminder = reminder {
                        if !isInitalize {
                            // If an existing reminder is passed, pre-populate the fields
                            time = reminder.reminderTime
                            selectedRepeatOptions = reminder.repeatOption
                            category = reminder.category
                            label = reminder.label
                            //sound = reminder.reminderSound
                            isInitalize = true
                        }
                       
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
                        reminder.repeatOption = selectedRepeatOptions
                        
                        //reminder.reminderSound = sound
                        reminder.category = category  // Update the category
                        
                        // Save the updated reminder in the modelContext
                        reminderViewModel.updateReminder(reminder, isOn: reminder.isReminderOn, context: modelContext)
                        print("selected repeat option: \(selectedRepeatOptions)")
                        
                        // check the published reminder status
                        //reminderViewModel.checkReminderStatus(for: reminder)
                    } else {
                        // Insert a new reminder model into the SwiftData context
                        let newReminder = ReminderModel(
                            label: label,
                            reminderTime: time,
                            repeatOption: selectedRepeatOptions,
                            isReminderOn: true,
                            //reminderSound: sound,
                            category: category  // Initialize with selected category
                        )
                        modelContext.insert(newReminder)
                        print("New Reminder Category: \(newReminder.category)")
                        print("selected repeat option: \(selectedRepeatOptions)")
                        
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

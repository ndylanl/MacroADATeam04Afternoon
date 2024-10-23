//
//  ReminderListView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 08/10/24.
//

import SwiftUI
import SwiftData

struct ReminderListView: View {
    @State private var isPresented: Bool = false
    @State private var selectedReminder: ReminderModel? = nil  // Track the selected reminder for editing
    @Environment(\.modelContext) private var modelContext // Fetch from SwiftData
    @Query private var reminders: [ReminderModel]         // Query reminders from SwiftData
    @ObservedObject var reminderViewModel = ReminderViewModel()
    
    var body: some View {
        VStack {
            List {
                if reminders.isEmpty {
                    Text("No reminders yet")
                        .foregroundColor(.gray)
                        .font(.headline)
                        .padding()
                } else {
                    ForEach(reminders) { reminder in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(reminder.reminderTime, style: .time) // Fetch reminderTime from ReminderModel
                                    .font(.system(size: 48, weight: .light, design: .default))
                                
                                Spacer()
                                
                                // Use Binding to modify the toggle state and save to the database
                                Toggle("", isOn: Binding(
                                    get: { reminder.isReminderOn },
                                    set: { newValue in
                                        // Update reminder's state in the modelContext
                                        reminderViewModel.updateReminder(reminder, isOn: newValue, context: modelContext)
                                    }
                                ))
                                .tint(Color.blue) // Set the color of the toggle
                            }
                            
                            Text(reminder.label)
                        }
                        .contentShape(Rectangle())  // Makes the entire VStack tappable
                        .onTapGesture {
                            // When tapped, set selectedReminder and show AddReminderView for editing
                            selectedReminder = reminder
                            isPresented = true
                        }
                    }
                    .onDelete(perform: deleteReminder) // Add swipe-to-delete functionality
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Reminders")
            .navigationBarItems(trailing: Button(action: {
                selectedReminder = nil  // Reset selectedReminder for adding a new reminder
                isPresented = true  // Show modal sheet to add a new reminder
            }) {
                Image(systemName: "plus").font(.title3)
            })
            .sheet(isPresented: $isPresented) {
                // Pass the selected reminder for editing, or nil for adding a new one
                AddReminderView(reminder: $selectedReminder)
            }
        }
    }
    
    // Function to handle deletion of reminders
    private func deleteReminder(at offsets: IndexSet) {
        for index in offsets {
            let reminderToDelete = reminders[index]
            modelContext.delete(reminderToDelete) // Remove from SwiftData context
        }
    }
}

//
//#Preview {
//    ReminderListView()
//}

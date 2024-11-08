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
    @State var isSelected: Bool = false
    var body: some View {
        
        VStack(alignment: .center) {
            if reminders.isEmpty {
                // Display the empty state when there are no reminders
                VStack {
                    Spacer()
                    Image("reminder")
                    Text("You have no reminders yet")
                        .foregroundColor(.gray)
                        .font(.body)
                        .padding()
                    Spacer()
                }
            } else {
                List {
                    ForEach(reminders) { reminder in
                        Button {
                                selectedReminder = reminder
                                isPresented = true
                        } label: {
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
                                    .tint(Color("PrimaryColor")) // Set the color of the toggle
                                }
                                HStack {
                                    Text("\(reminder.label)\( !reminder.label.isEmpty && !reminder.repeatOption.isEmpty && reminder.repeatOption != [.never] ? "," : "")")
                                    
                                    if !reminder.repeatOption.isEmpty && reminder.repeatOption != [.never] {
                                        Text(reminder.repeatOption
                                            .filter { $0 != .never }
                                            .map { $0.rawValue }
                                            .joined(separator: ", "))
                                    }
                                }
                                
                                
                                
                                
                            }
                        }
                    }
                    .onDelete(perform: deleteReminder) // Add swipe-to-delete functionality
                    //.listRowBackground(Color.clear)
                }
                .frame(width: UIScreen.main.bounds.width)
                .listStyle(.plain)
            }
        }
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

    
    // Function to handle deletion of reminders
    private func deleteReminder(at offsets: IndexSet) {
        for index in offsets {
            let reminderToDelete = reminders[index]
            modelContext.delete(reminderToDelete) // Remove from SwiftData context
        }
    }
}


#Preview {
    ReminderListView()
}

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
//    @Query(sort: \ReminderModel.reminderTime, order: .forward) var reminders: [ReminderModel]
    @ObservedObject var reminderViewModel = ReminderViewModel()
    @State var isSelected: Bool = false
    
    @State var sortedReminder: [ReminderModel] = []
    
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
                    ForEach(sortedReminder) { reminder in
                        
                        Button {
                                selectedReminder = reminder
                                isPresented = true
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(reminder.reminderTime, style: .time)
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
                                    Text(
                                        "\(reminder.label)" +
                                        (!reminder.label.isEmpty && !reminder.repeatOption.isEmpty && reminder.repeatOption != [.never] ? ", " : "") +
                                        reminder.repeatOption
                                            .filter { $0 != .never }
                                            .sorted { RepeatOption.allCases.firstIndex(of: $0)! < RepeatOption.allCases.firstIndex(of: $1)! }
                                            .enumerated()
                                            .map { index, option in
                                                let isLastItem = index == reminder.repeatOption.count - 1
                                                _ = index == reminder.repeatOption.count - 2
                                                
                                                // For exactly two options, use full names with "and" between
                                                if reminder.repeatOption.count == 2 {
                                                    return index == 0 ? option.rawValue : " and \(option.rawValue)"
                                                }
                                                // For more than two options, abbreviate and add "and" before the last item
                                                else if reminder.repeatOption.count > 2 {
                                                    let abbreviated = String(option.rawValue.prefix(3))
                                                    return isLastItem ? "and \(abbreviated)" : abbreviated
                                                }
                                                // For only one option, show the full name
                                                else {
                                                    return option.rawValue
                                                }
                                            }
                                            .joined(separator: reminder.repeatOption.count > 2 ? ", " : "")
                                    )
                                    .font(.system(size: 15))
                                }


                                
                            }
                        }
                    }
                    .onDelete(perform: deleteReminder) // Add swipe-to-delete functionality
                    //.listRowBackground(Color.clear)
                    .onAppear {
                        
                    }
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
        .onAppear {
            print(reminders)
            sortedReminder = reminderViewModel.sortByTime(reminders: reminders)
        }
        .onChange(of: reminders) { _, _ in
            sortedReminder = reminderViewModel.sortByTime(reminders: reminders)
        }
    }

    
    // Function to handle deletion of reminders
    private func deleteReminder(at offsets: IndexSet) {
        for index in offsets {
            let reminderToDelete = sortedReminder[index]
            modelContext.delete(reminderToDelete) // Remove from SwiftData context
        }
    }
}


#Preview {
    ReminderListView()
}

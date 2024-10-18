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
    @State private var label: String = ""
    @Environment(\.modelContext) private var modelContext // Fetch from SwiftData
    @Query private var reminders: [ReminderModel]         // Query reminders from SwiftData
    @ObservedObject var reminderViewModel = ReminderViewModel()
    
    var body: some View {
        NavigationView {
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
                        
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Reminders")
            .navigationBarItems(trailing: Button(action: {
                isPresented = true  // Show modal sheet to add a new reminder
            }) {
                Image(systemName: "plus").font(.title3)
            })
            .sheet(isPresented: $isPresented) {
                AddReminderView()
            }
        }
    }
    
//    func updateReminder(_ reminder: ReminderModel, isOn: Bool) {
//        reminder.isReminderOn = isOn
//        do {
//            try modelContext.save()  // Save changes to the database
//            // Jika isOn adalah false, batalkan notifikasi
//            if !isOn {
//                // Batalkan notifikasi untuk reminder ini
//                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminder.id.uuidString])
//            } else {
//                // Jika isOn adalah true, jadwalkan notifikasi baru jika diperlukan
//                reminderViewModel.scheduleReminderNotification(for: reminder)
//            }
//        } catch {
//            print("Error saving reminder state: \(error)")
//        }
//    }
}
//
//#Preview {
//    ReminderListView()
//}

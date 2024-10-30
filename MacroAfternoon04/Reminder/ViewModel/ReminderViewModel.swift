//
//  ReminderViewModel.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 16/10/24.
//

import SwiftUI
import UserNotifications
import SwiftData

class ReminderViewModel: ObservableObject {
    
    func handleMarkAsDone(reminderID: String) {
        print("User marked reminder as Done: \(reminderID)")
            //call getReminderBasedOnId func
        if let reminder = ReminderService.shared.getReminderBasedOnId(reminderID: reminderID) {
            // Mark reminder as completed
            reminder.isCompleted = true
            //saveReminder(reminder, context: context)
            if let context = ReminderService.shared.modelContext {
                saveContext(context: context)
            }

        }
        
    }

    
    func handleSnooze(reminderID: String) {
        print("User selected Snooze for reminder: \(reminderID)")

        // Fetch the reminder model using its ID
        if let reminder = ReminderService.shared.getReminderBasedOnId(reminderID: reminderID) {
            
            // Reschedule the notification for the new reminder time
            scheduleSnoozeNotification(for: reminder)
            
            // Save the updated reminder to the context if necessary
            //ReminderService.shared.saveReminder(reminder)
            if let context = ReminderService.shared.modelContext {
                saveContext(context: context)
            }
            
            print("Reminder snoozed for 1 hour.")
        }
    }

    // Function to schedule the snoozed notification
    func scheduleSnoozeNotification(for reminder: ReminderModel) {
        let content = UNMutableNotificationContent()
        content.title = "Serene"
        content.body = reminder.label
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "REMINDER_CATEGORY"

        // Create the trigger for 1 hour later
        let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: false)

        let request = UNNotificationRequest(identifier: reminder.id.uuidString, content: content, trigger: newTrigger)
        
        // Add the notification request
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling snoozed notification: \(error)")
            }
        }
    }

    
    func scheduleReminderNotification(for reminder: ReminderModel) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: reminder.reminderTime)
        let minute = calendar.component(.minute, from: reminder.reminderTime)

        checkForPermissions(label: reminder.label, id: reminder.id, at: hour, minute: minute, repeatOption: reminder.repeatOption)
    }

    func updateReminder(_ reminder: ReminderModel, isOn: Bool, context: ModelContext) {
        reminder.isReminderOn = isOn
        
            if !isOn {
                // Batalkan notifikasi
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminder.id.uuidString])
            } else {
                // Jadwalkan notifikasi baru
                scheduleReminderNotification(for: reminder)
            }
        
        saveContext(context: context)
    }
    
    
    func saveReminder(_ reminder: ReminderModel, context: ModelContext) {
            // Insert new or updated reminder into the context
            context.insert(reminder)
            
            // Save changes to the context
            saveContext(context: context)
            
            // Schedule notification for the reminder
            if reminder.isReminderOn {
                scheduleReminderNotification(for: reminder)
            }
        }
    
    // Helper function to save the context and handle potential errors
        private func saveContext(context: ModelContext) {
            do {
                // Save changes to the context
                try context.save()
            } catch {
                print("Error saving reminder: \(error)")
            }
        }
}

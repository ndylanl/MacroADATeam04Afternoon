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
    
    @Published var publishedRemindersCount = 0
    private var weeklyResetTimer: Timer?
    
//    init() {
//        setupWeeklyReset()
//    }
//    
//    func checkReminderStatus(for reminder: ReminderModel) {
//        let now = Date()
////        var components = DateComponents()
////        components.year = 2024
////        components.month = 11
////        components.day = 4
////        components.hour = 20
////        components.minute = 01
////        let now = Calendar.current.date(from: components)!
//
//        print("Checking reminder: \(reminder.label) at \(now)")
//        print("Reminder time: \(reminder.reminderTime), isActive: \(reminder.isActive)")
//
//        if reminder.reminderTime < now && reminder.isActive {
//            publishedRemindersCount += 1
//            print("Missed reminders count: \(publishedRemindersCount)")
//        } else {
//            print("Condition not met: \(reminder.reminderTime < now), \(reminder.isActive)")
//        }
//    }
//
//
//    private func setupWeeklyReset() {
//        // Set the timer to reset the counter every week
//        weeklyResetTimer = Timer.scheduledTimer(withTimeInterval: 604800, repeats: true) { _ in
//            self.resetMissedRemindersCount()
//        }
//    }
//    
//    private func resetMissedRemindersCount() {
//        publishedRemindersCount = 0
//    }
//    
//    deinit {
//        weeklyResetTimer?.invalidate()
//    }
    
//    func incrementPassedRemindersCount() {
//        let now = Date()
//        
//        // Get all active reminders (assuming you already have a function to fetch these)
//        let activeReminders = ReminderService.shared.getAllActiveReminders()
//        
//        for reminder in activeReminders {
//            // Check if the reminder time has passed and it’s still active
//            if reminder.reminderTime < now && reminder.isReminderOn && reminder.isActive {
//                reminder.missedCount += 1
//                print("Incremented missed count for \(reminder.label) to \(reminder.missedCount)")
//            }
//            
//        }
//    }
    
//    func incrementPassedRemindersCount() {
//        print("Checking reminders for missed alarms...")
//
//        // Fetch all active reminders
//        let activeReminders = ReminderService.shared.getAllActiveReminders()
//        
//        activeReminders.forEach { reminder in
//            if reminder.reminderTime < Date() {
//                print("Reminder \(reminder.label) has passed. Current missed count: \(reminder.missedCount)")
//                
//                // Increment the count
//                reminder.missedCount += 1
//                
//                // Save the updated count (assuming you have a save method)
//                save(reminder)
//                
//                print("Updated missed count for \(reminder.label) to \(reminder.missedCount)")
//            } else {
//                print("Reminder \(reminder.label) is still active and not missed.")
//            }
//        }
//    }
    
//    private func save(_ reminder: ReminderModel) {
//        // Assuming there's a save method to persist the reminder changes
//        // Add a print statement here as well to confirm the save action
//        print("Saving reminder \(reminder.label) with missed count \(reminder.missedCount)")
//        // Actual save logic here
//    }
    
    func deductPoints(for reminder: ReminderModel) {
        // Deduct 1 point from the corresponding category if the points are greater than 0
        switch reminder.category {
        case .appointment:
            if reminder.appointmentPoint > 0 {
                reminder.appointmentPoint -= 1
                print("Decreased appointment points to \(reminder.appointmentPoint) for \(reminder.label)")
            }
        case .apply:
            if reminder.applyPoint > 0 {
                reminder.applyPoint -= 1
                print("Decreased apply points to \(reminder.applyPoint) for \(reminder.label)")
            }
        case .consume:
            if reminder.consumePoint > 0 {
                reminder.consumePoint -= 1
                print("Decreased consume points to \(reminder.consumePoint) for \(reminder.label)")
            }
        case .exercise:
            if reminder.exercisePoint > 0 {
                reminder.exercisePoint -= 1
                print("Decreased exercise points to \(reminder.exercisePoint) for \(reminder.label)")
            }
        case .other:
            if reminder.otherPoint > 0 {
                reminder.otherPoint -= 1
                print("Decreased other points to \(reminder.otherPoint) for \(reminder.label)")
            }
        }
    }


    
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
        
        
        checkForPermissions(label: reminder.label, id: reminder.id, at: hour, minute: minute, repeatOptions: reminder.repeatOption)
        print("scheduling reminder for \(reminder.label) at \(hour):\(minute)")
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

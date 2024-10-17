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
    func scheduleReminderNotification(for reminder: ReminderModel) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: reminder.reminderTime)
        let minute = calendar.component(.minute, from: reminder.reminderTime)

        checkForPermissions(label: reminder.label, id: reminder.id, at: hour, minute: minute)
    }

    func updateReminder(_ reminder: ReminderModel, isOn: Bool, context: ModelContext) {
        reminder.isReminderOn = isOn
        
//        do {
            if !isOn {
                // Batalkan notifikasi
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminder.id.uuidString])
            } else {
                // Jadwalkan notifikasi baru
                scheduleReminderNotification(for: reminder)
            }
//        } catch {
//            print("Error saving reminder state: \(error)")
//        }
    }
}

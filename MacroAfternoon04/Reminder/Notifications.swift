//
//  Notifications.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 10/10/24.
//

import UserNotifications

func checkForPermissions(label: String, id: UUID, at hour: Int, minute: Int) {
    let notificationCenter = UNUserNotificationCenter.current()
    
    notificationCenter.getNotificationSettings { settings in
        switch settings.authorizationStatus {
        case .authorized:
            // Directly call the function since there's no self
            dispatchNotification(label: label, id: id, at: hour, minute: minute)
        case .denied:
             break
        case .notDetermined:
            notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { didAllow, error in
                if didAllow {
                    dispatchNotification(label: label, id: id, at: hour, minute: minute)
                }
            }
        case .provisional:
            break
        case .ephemeral:
            break
        @unknown default:
            print("Unknown")
        }
    }
}

func dispatchNotification(label: String, id: UUID, at hour: Int, minute: Int) {
    let identifier = id.uuidString // Unique identifier for each reminder
    let title = "Hair Daily Reminder"
    let body = "It's time to \(label)!"

    let notificationCenter = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = .default
    
    var dateComponents = DateComponents()
    dateComponents.hour = hour
    dateComponents.minute = minute
    
    // Create a trigger based on the dateComponents
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
    // Remove any existing notifications with the same identifier to avoid duplicates
    notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    
    // Add the new notification request
    notificationCenter.add(request) { error in
        if let error = error {
            print("Error adding notification: \(error.localizedDescription)")
        } else {
            print("Notification scheduled successfully!")
        }
    }
}

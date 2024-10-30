//
//  Notifications.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 10/10/24.
//

import UserNotifications

func checkForPermissions(label: String, id: UUID, at hour: Int, minute: Int, repeatOption: RepeatOption) {
    let notificationCenter = UNUserNotificationCenter.current()
    
    notificationCenter.getNotificationSettings { settings in
        switch settings.authorizationStatus {
        case .authorized:
            // Directly call the function since there's no self
            dispatchNotification(label: label, id: id, at: hour, minute: minute, repeatOption: repeatOption)
        case .denied:
             break
        case .notDetermined:
            notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { didAllow, error in
                if didAllow {
                    dispatchNotification(label: label, id: id, at: hour, minute: minute, repeatOption: repeatOption)
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

func setupNotificationActions() {
    let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION",
                                            title: "Remind Me Later",
                                            options: [])

    let doneAction = UNNotificationAction(identifier: "DONE_ACTION",
                                          title: "Mark as Done",
                                          options: [.foreground])

    let category = UNNotificationCategory(identifier: "REMINDER_CATEGORY",
                                          actions: [snoozeAction, doneAction],
                                          intentIdentifiers: [],
                                          options: [])
    
    UNUserNotificationCenter.current().setNotificationCategories([category])
}

func dispatchNotification(label: String, id: UUID, at hour: Int, minute: Int, repeatOption: RepeatOption) {
    let identifier = id.uuidString
    let title = "Serene"
    let body = "Reminder: \(label)!"
    let notificationCenter = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = .default
    content.categoryIdentifier = "REMINDER_CATEGORY"
    
    // Remove any existing notifications with the same identifier to avoid duplicates
    notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    
    // Configure date components with time
    var dateComponents = DateComponents()
    dateComponents.hour = hour
    dateComponents.minute = minute
    
    // Set the weekday based on the repeat option
    switch repeatOption {
    case .monday:
        dateComponents.weekday = 2 // Monday
    case .tuesday:
        dateComponents.weekday = 3 // Tuesday
    case .wednesday:
        dateComponents.weekday = 4 // Wednesday
    case .thursday:
        dateComponents.weekday = 5 // Thursday
    case .friday:
        dateComponents.weekday = 6 // Friday
    case .saturday:
        dateComponents.weekday = 7 // Saturday
    case .sunday:
        dateComponents.weekday = 1 // Sunday
    case .never:
        // If `never`, set a one-time trigger without repeating
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("One-time notification scheduled successfully!")
            }
        }
        return
    }
    
    // For other repeat options, create a repeating trigger
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
    notificationCenter.add(request) { error in
        if let error = error {
            print("Error scheduling notification: \(error.localizedDescription)")
        } else {
            print("Repeating notification scheduled successfully!")
        }
    }
}




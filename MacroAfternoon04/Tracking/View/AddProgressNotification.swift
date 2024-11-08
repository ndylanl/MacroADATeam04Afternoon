//
//  AddProgressNotification.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 06/11/24.
//

import Foundation
import UserNotifications

public func addProgressNotification(selectedDay: Int) {
    
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        if success {
            // Authorization granted, proceed with scheduling the notification
            cancelProgressNotification()
            
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = "Take photos today!!!!!!"
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.weekday = selectedDay
            dateComponents.hour = 9
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            
            let request = UNNotificationRequest(identifier: "progress", content: content, trigger: trigger)
            
            print("NOTICE!!!!!!!!!!")
            
            UNUserNotificationCenter.current().add(request)
        } else if let error {
            // Authorization denied or an error occurred
            print("Authorization failed: \(error.localizedDescription)")
        } else {
            // Authorization denied without an error
            print("Authorization denied")
        }
    }
}

public func cancelProgressNotification() {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["progress"])
}

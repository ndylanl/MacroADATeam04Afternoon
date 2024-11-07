//
//  AddProgressNotification.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 06/11/24.
//

import Foundation
import UserNotifications

public func addProgressNotification(selectedDay: Int) {
    cancelProgressNotification()
    
    let content = UNMutableNotificationContent()
    content.title = "Reminder"
    content.body = "Take photos today!!!!!!"
    content.sound = .default
    
    var dateComponents = DateComponents()
    dateComponents.weekday = selectedDay
    dateComponents.hour = 18
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
    
    let request = UNNotificationRequest(identifier: "progress", content: content, trigger: trigger)
    
    print("NOTICE!!!!!!!!!!")
    
    UNUserNotificationCenter.current().add(request)
}

public func cancelProgressNotification() {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["progress"])
}

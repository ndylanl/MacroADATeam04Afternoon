//
//  AppDelegate.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 29/10/24.
//

import UIKit
import UserNotifications
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    let reminderViewModel = ReminderViewModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let reminderID = response.notification.request.identifier

        switch response.actionIdentifier {
        case "SNOOZE_ACTION":
            reminderViewModel.handleSnooze(reminderID: reminderID)
        case "DONE_ACTION":
            print("done action")
            reminderViewModel.handleMarkAsDone(reminderID: reminderID)
        default:
            break
        }
        completionHandler()
    }

}

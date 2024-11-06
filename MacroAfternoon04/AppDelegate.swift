//
//  AppDelegate.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 29/10/24.
//

import UIKit
import UserNotifications
import SwiftUI
import BackgroundTasks

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    let taskId = "updateReminderStatusCount"
    let reminderViewModel = ReminderViewModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let reminderID = response.notification.request.identifier
        
        print("Received notification for reminder ID: \(reminderID)")

        switch response.actionIdentifier {
        case "SNOOZE_ACTION":
            // Call handleSnooze to reschedule the reminder
            reminderViewModel.handleSnooze(reminderID: reminderID)

            // Deduct points from the corresponding category after snoozing
            if let reminder = ReminderService.shared.getReminderBasedOnId(reminderID: reminderID) {
                reminderViewModel.deductPoints(for: reminder)
            }
            
        case "DONE_ACTION":
            print("done action")
            reminderViewModel.handleMarkAsDone(reminderID: reminderID)
        default:
            break
        }
        
        completionHandler()
    }


}

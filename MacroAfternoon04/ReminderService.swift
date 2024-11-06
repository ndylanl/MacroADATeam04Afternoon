//
//  ReminderService.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 29/10/24.
//

import Foundation
import SwiftData

class ReminderService: ObservableObject {
    static let shared = ReminderService()
    var modelContext: ModelContext? // The optional model context value
    
    
    func getReminderBasedOnId(reminderID: String) -> ReminderModel? {
        var resultModel: ReminderModel? = nil
        print("get: ReminderID: \(reminderID)")
        if let id = UUID(uuidString: reminderID) {
            let fetchRequest = FetchDescriptor<ReminderModel>(
                predicate: #Predicate<ReminderModel> { $0.id == id },
                sortBy: [SortDescriptor(\.id, order: .reverse)]
            )
            
            do {
                if let context = modelContext {
                    let models = try context.fetch(fetchRequest)
                    models.forEach { m in
                        print(m.id)
                    }
                    if let lastModel = models.first {
                        print("get: lastModel: \(lastModel)")
                        resultModel = lastModel
                    } else {
                        print("get: lastModel: nothing")
                    }
                }
                
            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
        return resultModel
    }
    
    func getAllActiveReminders() -> [ReminderModel] {
        var activeReminders: [ReminderModel] = []
        
        // Define a fetch descriptor to get reminders where `isReminderOn` is true
        let fetchRequest = FetchDescriptor<ReminderModel>(
            predicate: #Predicate<ReminderModel> { $0.isReminderOn == true },
            sortBy: [SortDescriptor(\.reminderTime, order: .forward)]
        )
        
        do {
            if let context = modelContext {
                // Fetch the reminders based on the criteria
                let reminders = try context.fetch(fetchRequest)
                
                // Print reminder details and add them to the activeReminders array
                reminders.forEach { reminder in
                    print("Active Reminder: \(reminder.label), Time: \(reminder.reminderTime), Repeat Option: \(reminder.repeatOption)")
                    activeReminders.append(reminder)
                }
            }
            
        } catch {
            print("Failed to fetch active reminders: \(error)")
        }
        
        return activeReminders
    }
    
    func resetWeeklyPointsIfNeeded() {
        let now = Date()
        let calendar = Calendar.current
        
        // Get all reminders
        let allReminders = getAllActiveReminders() 
        
        for reminder in allReminders {
            // Check if a week has passed since the last reset
            if let lastResetDate = reminder.lastResetDate {
                if calendar.isDateInToday(lastResetDate) == false {
                    // Check if it's been more than a week
                    if now.timeIntervalSince(lastResetDate) > 604800 { // 604800 seconds in a week
                        reminder.resetPoints()
                        reminder.lastResetDate = now // Update last reset date
                        print("Resetting weekly points")
                    }
                }
            } else {
                // First time resetting
                reminder.resetPoints()
                reminder.lastResetDate = now
            }
        }
    }

}

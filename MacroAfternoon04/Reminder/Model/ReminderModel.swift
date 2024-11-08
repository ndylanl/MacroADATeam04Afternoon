//
//  ReminderModel.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 09/10/24.
//

import Foundation
import SwiftData

enum RepeatOption: String, Codable, CaseIterable {
    case never = "Never"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
}


enum Sound: String, Codable, CaseIterable {
    case defaultSound = "Default"
    case sound1 = "Sound 1"
    case sound2 = "Sound 2"
    case sound3 = "Sound 3"
}

enum ReminderCategory: String, Codable, CaseIterable {
    case appointment = "Appointment"
    case apply = "Apply"
    case consume = "Consume"
    case exercise = "Exercise"
    case other = "Other"
}

extension ReminderModel {
    func resetPoints() {
        self.appointmentPoint = 100
        self.applyPoint = 100
        self.consumePoint = 100
        self.exercisePoint = 100
        self.otherPoint = 100
        print("Points reset to 100 for reminder: \(self.label)")
    }
}

@Model
class ReminderModel {
    @Attribute var id: UUID = UUID()
    @Attribute var label: String
    @Attribute var reminderTime: Date // The target time for the reminder
    @Attribute var repeatOption: [RepeatOption] 
    @Attribute var isReminderOn: Bool
    @Attribute var reminderSound: Sound
    @Attribute var category: ReminderCategory
    @Attribute var isCompleted: Bool = false
    @Attribute var dateCreated: Date = Date() // Track creation date of the reminder
    @Attribute var isActive: Bool = true // Indicates if the reminder is currently active
    @Attribute var appointmentPoint: Int = 100
    @Attribute var applyPoint: Int = 100
    @Attribute var consumePoint: Int = 100
    @Attribute var exercisePoint: Int = 100
    @Attribute var otherPoint: Int = 100
    @Attribute var lastResetDate: Date? // Track the last reset date


    init(label: String, reminderTime: Date, repeatOption: [RepeatOption], isReminderOn: Bool, reminderSound: Sound = .defaultSound, category: ReminderCategory = .other) {
        self.label = label
        self.reminderTime = reminderTime
        self.repeatOption = repeatOption
        self.isReminderOn = isReminderOn
        self.reminderSound = reminderSound
        self.category = category
        self.isActive = true
        self.lastResetDate = nil
    }
}










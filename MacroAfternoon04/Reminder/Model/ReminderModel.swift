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
    case monday = "Every Monday"
    case tuesday = "Every Tuesday"
    case wednesday = "Every Wednesday"
    case thursday = "Every Thursday"
    case friday = "Every Friday"
    case saturday = "Every Saturday"
    case sunday = "Every Sunday"
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

@Model
class ReminderModel {
    @Attribute var id: UUID = UUID() // Automatically initialized
    @Attribute var label: String
    @Attribute var reminderTime: Date
    @Attribute var repeatOption: RepeatOption
    @Attribute var isReminderOn: Bool
    @Attribute var reminderSound: Sound
    @Attribute var category: ReminderCategory
    @Attribute var isCompleted: Bool = false
    
//    @Persisted var reminderSound: Sound

    init(label: String, reminderTime: Date, repeatOption: RepeatOption, isReminderOn: Bool, reminderSound: Sound = .defaultSound, category: ReminderCategory = .other) {
        self.label = label
        self.reminderTime = reminderTime
        self.repeatOption = repeatOption
        self.isReminderOn = isReminderOn
        self.reminderSound = reminderSound
        self.category = category
    }
}






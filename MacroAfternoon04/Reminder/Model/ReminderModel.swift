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
    case hourly = "Hourly"
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
}

enum Sound: String, Codable, CaseIterable {
    case defaultSound = "Default"
    case sound1 = "Sound 1"
    case sound2 = "Sound 2"
    case sound3 = "Sound 3"
}

@Model
class ReminderModel {


    @Attribute var id: UUID = UUID() // Automatically initialized
    @Attribute var label: String
    @Attribute var reminderTime: Date
    @Attribute var repeatOption: RepeatOption
    @Attribute var isReminderOn: Bool
    @Attribute var reminderSound: Sound
    
//    @Persisted var reminderSound: Sound

    init(label: String, reminderTime: Date, repeatOption: RepeatOption, isReminderOn: Bool, reminderSound: Sound = .defaultSound) {
        self.label = label
        self.reminderTime = reminderTime
        self.repeatOption = repeatOption
        self.isReminderOn = isReminderOn
        self.reminderSound = reminderSound
    }
}






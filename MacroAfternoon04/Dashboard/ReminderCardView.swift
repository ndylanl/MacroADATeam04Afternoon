//
//  ReminderCardView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 09/10/24.
//

import SwiftUI
import SwiftData

struct ReminderCardView: View {
    @Environment(\.modelContext) private var modelContext // Environment to access the database
    @Query private var reminders: [ReminderModel]         // Query reminders from SwiftData
    
    var body: some View {
        ZStack {
            RoundedCornerComponentView()
            
            VStack(alignment: .leading) {
                Text("Reminder")
                    .font(.footnote)
                    .foregroundStyle(.black)
                
                Divider()
                
                if reminders.isEmpty {
                    // Tampilan ketika tidak ada reminder
                    Text("+ Add New Reminder")
                        .font(.title)
                    
                    Text("You have no reminders yet")
                        .font(.body)
                } else {
                    // Filter reminders yang aktif dan sort berdasarkan waktu terdekat
                    let nextReminder = reminders
                        .filter { $0.isReminderOn }
                        .sorted(by: { $0.reminderTime.timeIntervalSinceNow < $1.reminderTime.timeIntervalSinceNow })
                        .first
                    // Tampilkan reminder terdekat berdasarkan waktunya
                    if let nextReminder = nextReminder {
                        // Tampilkan reminder terdekat berdasarkan waktunya
                        Text(nextReminder.label)
                            .font(.title)
                        Text("\(nextReminder.reminderTime, style: .time)")
                            .font(.body)
                    } else {
                        // Jika ada reminder tapi tidak ada yang aktif
                        Text("+ Add New Reminder")
                            .font(.title)
                        
                        Text("You have no active reminders")
                            .font(.body)
                    }

                }
       
            }
            .foregroundStyle(Color.primary)
            .frame(width: cardWidthSize() - 32, height: cardHeightSize() - 24)
        }
        .frame(width: cardWidthSize(), height: cardHeightSize())
    }
    
    func cardWidthSize() -> CGFloat {
        (UIScreen.main.bounds.width * 374 / 430)
    }
    
    func cardHeightSize() -> CGFloat {
        (UIScreen.main.bounds.height * 142 / 985)
    }
}


#Preview {
    ReminderCardView()
}


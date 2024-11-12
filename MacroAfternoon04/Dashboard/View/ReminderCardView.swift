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
            RoundedCornerComponentBlueView()
            
            VStack(alignment: .leading) {

                
                if reminders.isEmpty {
                    // Tampilan ketika tidak ada reminder
                    HStack{
                        Image(systemName: "bell.fill")
                        Text("Add New Reminder")
                        Spacer()
                        Image(systemName: "chevron.right")
                        
                    }
                    .font(.system(size: 24))
                    .foregroundStyle(Color("PrimaryColor"))
                    
                    
                    Text("You have no reminders yet")
                        .font(.body)
                        .foregroundStyle(Color("NeutralColor"))
                } else {
                    // Filter reminders yang aktif dan sort berdasarkan waktu terdekat
                    let nextReminder = reminders
                        .filter { $0.isReminderOn }
                        .sorted(by: { $0.reminderTime.timeIntervalSinceNow < $1.reminderTime.timeIntervalSinceNow })
                        .first
                    // Tampilkan reminder terdekat berdasarkan waktunya
                    if let nextReminder = nextReminder {
                        // Tampilkan reminder terdekat berdasarkan waktunya
                        HStack{
                            Image(systemName: "bell.fill")
                            Text(nextReminder.label)
                            Spacer()
                            Image(systemName: "chevron.right")
                            
                        }
                        .font(.system(size: 24))
                        .foregroundStyle(Color("PrimaryColor"))
                        
//                        Text(nextReminder.label)
//                            .font(.title)
//                            .multilineTextAlignment(.leading)
//                            .foregroundStyle(Color("PrimaryColor"))
                        Text("\(nextReminder.reminderTime, style: .time)")
                            .font(.body)
                            .foregroundStyle(Color.black)
                    } else {
                        // Jika ada reminder tapi tidak ada yang aktif
                        HStack{
                            Image(systemName: "bell.fill")
                            Text("Add New Reminder")
                            Spacer()
                            Image(systemName: "chevron.right")
                            
                        }
                        .font(.system(size: 24))
                        .foregroundStyle(Color("PrimaryColor"))
                        
                        
                        Text("You have no reminders yet")
                            .font(.body)
                            .foregroundStyle(Color("NeutralColor"))
                    }

                }
       
            }
            
            .frame(width: cardWidthSize() - 32, height: cardHeightSize() - 24)
        }
        .frame(width: cardWidthSize(), height: cardHeightSize())
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("PrimaryColor"), lineWidth: 0.5))
        //.shadow(radius:3, x:0, y:1)
        .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 2)
    }
    
    func cardWidthSize() -> CGFloat {
        (UIScreen.main.bounds.width * 374 / 430)
    }
    
    func cardHeightSize() -> CGFloat {
        (UIScreen.main.bounds.height * 92 / 964)
    }
}

//
#Preview {
    ReminderCardView()
}
//

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
}

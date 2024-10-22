//
//  WeeklyReportViewModel.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 16/10/24.
//

import Foundation
import SwiftUI
import Combine
import SwiftData

class WeeklyReportViewModel: ObservableObject {
    
    @Published var date: String = ""
    @Published var photos: [Data] = []
    var weekNumber: Int
    
    private var cancellables = Set<AnyCancellable>()
    private var modelContext: ModelContext
    
    init(weekNumber: Int, modelContext: ModelContext) {
        self.weekNumber = weekNumber
        self.modelContext = modelContext
        fetchData(weekNumber: weekNumber)
    }
    
//    init(modelContext: ModelContext) {
//        self.modelContext = modelContext
//        self.weekNumber = 1
//    }
    
    private func fetchData(weekNumber: Int) {
        print("week\(weekNumber)")
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: nil,
            sortBy: [SortDescriptor(\.dateTaken, order: .forward)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)
            guard weekNumber > 0 && weekNumber <= models.count else { return }
            
            let model = models[weekNumber - 1]
            self.date = DateFormatter.localizedString(from: model.dateTaken, dateStyle: .short, timeStyle: .none)
            self.photos = model.hairPicture.flatMap { $0 }
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
    
    func totalWeeks() -> Int {
            let fetchRequest = FetchDescriptor<TrackProgressModel>(
                predicate: nil,
                sortBy: [SortDescriptor(\.dateTaken, order: .reverse)]
            )
            
            do {
                let models = try modelContext.fetch(fetchRequest)
                return models.count
            } catch {
                print("Failed to fetch data: \(error)")
                return 0
            }
        }
}

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
    @Published var detections: [[DetectedObject]] = [[]]
    var weekNumber: Int
    
    private var cancellables = Set<AnyCancellable>()
    private var modelContext: ModelContext
    
    init(weekNumber: Int, modelContext: ModelContext) {
        self.weekNumber = weekNumber
        self.modelContext = modelContext
        fetchData(weekNumber: weekNumber)
    }
    
    private func fetchData(weekNumber: Int) {
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
            self.detections = model.detections
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
    
    func totalHairLabels(targetObjectDetection: [DetectedObject]) -> Dictionary<Int, Int> {
        var totalCounts: Dictionary<Int, Int> = [:]
        
        for object in targetObjectDetection {
            if let label = Int(object.label) {
                if totalCounts.keys.contains(label) {
                    totalCounts[label]! += 1
                } else {
                    totalCounts[label] = 1
                }
            }
        }
        
        return totalCounts
    }
    
    func totalAverageHair(targetObjectDetection: [DetectedObject]) -> Double {
        var totalLabels = 0
        let totalObjects = targetObjectDetection.count
        
        // Iterate through each DetectedObject to sum up the labels
        for object in targetObjectDetection {
            totalLabels += Int(object.label)!
        }
        
        // Calculate the average, ensuring to handle division by zero
        let average = totalObjects > 0 ? Double(totalLabels) / Double(totalObjects) : 0.0
        
        return average
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

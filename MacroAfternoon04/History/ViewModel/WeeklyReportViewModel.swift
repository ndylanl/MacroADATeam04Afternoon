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
    @Published var detections: [[DetectedObject]] = []
    @Published var weekNumber: Int = 0
    @Published var heatMapArray: [Float] = [0,0,0,0,0,0,0,0,0,0,0,0]
    //@Published var model: TrackProgressModel?
    
    private var cancellables = Set<AnyCancellable>()
    private var modelContext: ModelContext
    @Published var averageHairPerFollicle: Double = 10
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData(weekNumber: weekNumber)
    }
    
    func fetchData(weekNumber: Int) {
        print("week\(weekNumber)")
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: nil,
            sortBy: [SortDescriptor(\.dateTaken, order: .forward)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)
            guard weekNumber > 0 && weekNumber <= models.count else { return }
            
            let model = models[weekNumber - 1]
            print("Model:\(model)")
            date = DateFormatter.localizedString(from: model.dateTaken, dateStyle: .short, timeStyle: .none)
            photos = model.hairPicture.flatMap { $0.hairPicture }
            //photos = model.hairPicture
            print("Photos: \(photos.count)")
            detections = model.detections
            print("Detections: \(detections.count)")
            print(detections)
            averageHairPerFollicle = totalAverageHair(targetObjectDetection: detections)
            print("Average: \(averageHairPerFollicle)")
            heatMapArray = createArrayHeatMap(photos: photos, detections: detections)
            print("heatMapArray: \(heatMapArray)")
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
    
    func totalAverageHair(targetObjectDetection: [[DetectedObject]]) -> Double {
        var totalLabels = 0
        var totalObjects = 0
        
        // Iterate through each DetectedObject to sum up the labels
        for object in targetObjectDetection {
            for obj in object{
                totalLabels += Int(obj.label)!
                totalObjects += 1
            }
        }
        print("targetObjectDetection: \(targetObjectDetection.count)")
        print("totalObjects: \(totalObjects)")
        print("totalLabels: \(totalLabels)")
        
        // Calculate the average, ensuring to handle division by zero
        let average = totalObjects > 0 ? Double(totalLabels) / Double(totalObjects) : 0.0
        //print("Average: \(average)")
        return average
    }
    
    private func weekOfMonth(for date: Date) -> Int {
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
        return weekOfMonth
    }
    
    func reverseConvertNumber(_ number: Int) -> Int? {
        let reverseConversionTable: [Int: Int] = [
            6: 0,
            7: 1,
            8: 2,
            11: 3,
            12: 4,
            13: 5,
            16: 6,
            17: 7,
            18: 8,
            21: 9,
            22: 10,
            23: 11,
        ]
        
        return reverseConversionTable[number]
    }
    
    func createArrayHeatMap(photos: [Data], detections: [[DetectedObject]]) -> [Float] {
        var arrayToReturn : [Float] = []
        var averageToAppend = 1.0
        //print("photo count from createArrayHeatMap: \(photos.count)")

        if !photos.isEmpty{
            for i in 0...29{
                let validNumbers = [0, 1, 2, 3, 4, 5, 9, 10, 14, 15, 19, 20, 24, 25, 26, 27, 28, 29]
                
                if validNumbers.contains(i) {
                    arrayToReturn.append(1.0)
                } else {
                    // cuman buat check kalo dirandom valuenya
                    // averageToAppend = Double.random(in: 0..<1)
                    
                    if !detections[reverseConvertNumber(i)! + 1].isEmpty {
                        averageToAppend = sequentialAverageHair(targetObjectDetection: detections[reverseConvertNumber(i)! + 1])
                        if averageToAppend >= 3.0 {
                            averageToAppend = 3.0
                        }
                        averageToAppend = (averageToAppend - 1.0) / (3.0 - 1.0)
                    } else {
                        print("--------------------")
                        print(" CreateArrayHeatMap ")
                        print("  Empty Detections  ")
                        print("--------------------")
                        averageToAppend = 0
                    }
                    arrayToReturn.append(Float(averageToAppend))
                }
            }
        } else{
            
        }
        
        return arrayToReturn

    }
    
    func sequentialAverageHair(targetObjectDetection: [DetectedObject]) -> Double {
        var totalLabels = 0
        let totalObjects = targetObjectDetection.count
        
        for object in targetObjectDetection{
            totalLabels += Int(object.label)!
        }
        
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

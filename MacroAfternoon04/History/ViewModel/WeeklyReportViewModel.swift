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
    @Published var weekDate: Date = Date()
    @Published var heatMapArray: [Float] = [0,0,0,0,0,0,0,0,0,0,0,0]
    @Published var modelScalpPositions: String = ""
    @Published var model: TrackProgressModel?
    
    @Published var lastDate: Date = Date()
    
    @Published var sleepData = ""
    @Published var movementData = ""
    
    private var cancellables = Set<AnyCancellable>()
    private var modelContext: ModelContext
    @Published var averageHairPerFollicle: Double = 10
    
    init(modelContext: ModelContext, weekDate: Date) {
        self.modelContext = modelContext
        fetchData(weekDate: weekDate)
        fetchLastData()
    }
    
    @MainActor func setPersonalActivity(date: Date, healthViewModel: HealthViewModel){
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -7, to: date)
        healthViewModel.calculateAverageSleep(startDate: startDate!, endDate: date)
        healthViewModel.calculateAverageMovement(startDate: startDate!, endDate: date)
        
        sleepData = String(format: "%.1f", healthViewModel.averageSleep)
        movementData = String(format: "%.1f", healthViewModel.averageMovement)

        print("Sleep Data: \(sleepData)")
        print("Movement Data: \(movementData)")
    }
    
    func fetchData(weekDate: Date) {
        print("week\(weekNumber)")
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: nil,
            sortBy: [SortDescriptor(\.dateTaken, order: .forward)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)

            var model: TrackProgressModel = TrackProgressModel(hairPicture: [], detections: [], scalpPositions: "ScalpFull", appointmentPoint: 100, applyPoint: 100, consumePoint: 100, exercisePoint: 100, otherPoint: 100)
            
            for i in models{
                if i.dateTaken == weekDate {
                    model = i
                }
            }
            

            date = DateFormatter.localizedString(from: model.dateTaken, dateStyle: .short, timeStyle: .none)
            photos = model.hairPicture.flatMap { $0.hairPicture }
            modelScalpPositions = model.scalpPositions

            detections = model.detections

            print(detections)
            averageHairPerFollicle = totalAverageHair(targetObjectDetection: detections)
                        
            heatMapArray = createArrayHeatMap(photos: photos, detections: detections, scalpPositions: modelScalpPositions)
            
            //setPersonalActivity(date: model.dateTaken)
        } catch {
            print("Failed to fetch data: \(error)")
        }
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
        
        // Calculate the average, ensuring to handle division by zero
        let average = totalObjects > 0 ? Double(totalLabels) / Double(totalObjects) : 0.0
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
    
    func processCurrentScalpPositions(scalpPositions: String) -> [Int]{
        let optionsDict: [String: [Int]] = [
            "A. All Scalp": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
            "B. Left Side": [1, 4, 5, 7, 8, 10],
            "C. Right Side": [3, 5, 6, 8, 9, 12],
            "D. Front Side": [1, 2, 3, 4, 5, 6],
            "E. Middle Side": [3, 4, 5, 6, 7, 8],
            "F. Back Side": [7, 8, 9, 10, 11, 12],
        ]
        
        let currentPositions = optionsDict[scalpPositions]
        
        return currentPositions!
    }
    
    func createArrayHeatMap(photos: [Data], detections: [[DetectedObject]], scalpPositions: String) -> [Float] {
        var arrayToReturn : [Float] = []
        var averageToAppend = 1.0
        var validNumbers = [0, 1, 2, 3, 4, 5, 9, 10, 14, 15, 19, 20, 24, 25, 26, 27, 28, 29]
        var toAppend: [Int] = []
        
        if processCurrentScalpPositions(scalpPositions: scalpPositions).count == 6{
            let stringToIntArray: [String: [Int]] = [
                "B. Left Side": [7, 8, 13, 18, 22, 23],
                "C. Right Side": [6, 7, 11, 16, 21, 22],
                "D. Front Side": [16, 17, 18, 21, 22, 23],
                "E. Middle Side": [6, 7, 8, 21, 22, 23],
                "F. Back Side": [6, 7, 8, 11, 12, 13],
            ]
            toAppend = stringToIntArray[scalpPositions]!

            validNumbers += toAppend
            validNumbers.sort(by: <)
        }
        
        if !photos.isEmpty{
            var indexDetections = 1
            for i in 0...29{
                
                if validNumbers.contains(i) {
                    arrayToReturn.append(1.0)
                } else {
                    print("----------------------")
                    print(reverseConvertNumber(i)! + 1)

                    averageToAppend = sequentialAverageHair(targetObjectDetection: detections[indexDetections])
                    indexDetections += 1
                    if averageToAppend >= 3.0 {
                        averageToAppend = 3.0
                    }
                    averageToAppend = (averageToAppend - 1.0) / (3.0 - 1.0)

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
    
    func fetchLastData() {
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: nil,
            sortBy: [SortDescriptor(\.dateTaken, order: .reverse)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)
            guard let lastModel = models.first else { return }

            self.lastDate = lastModel.dateTaken
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}

//
//  MonthlyReportViewModel.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 06/11/24.
//

import Foundation
import SwiftUI
import Combine
import SwiftData

class MonthlyReportViewModel: ObservableObject {
    
    @Published var date: String = ""
    @Published var selectedMonthYear: Date
    @Published var detectionsA: [[DetectedObject]] = []
    @Published var detectionsB: [[DetectedObject]] = []

    @Published var weekNumber: Int = 0
    @Published var weekDate: Date = Date()
    @Published var heatMapArray: [Float] = [0,0,0,0,0,0,0,0,0,0,0,0]

    @Published var modelScalpPositions: String = ""
    @Published var model: TrackProgressModel?
    
    @Published var applySuggestion = true
    @Published var appointmentSuggestion = true
    @Published var consumeSuggestion = true
    @Published var exerciseSuggestion = true
    @Published var otherSuggestion = true
    
    @Published var hairGrowthStatus: String = "getting better"

    
    private var cancellables = Set<AnyCancellable>()
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext, selectedMonthYear: Date) {
        self.modelContext = modelContext
        self.selectedMonthYear = selectedMonthYear
        fetchData(weekDate: selectedMonthYear)
    }
    
    func fetchData(weekDate: Date) {
        print("week\(weekNumber)")
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: nil,
            sortBy: [SortDescriptor(\.dateTaken, order: .forward)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)
            
            var modelA: TrackProgressModel = TrackProgressModel(hairPicture: [], detections: [], scalpPositions: "ScalpFull", appointmentPoint: 100, applyPoint: 100, consumePoint: 100, exercisePoint: 100, otherPoint: 100)
            var modelB: TrackProgressModel = TrackProgressModel(hairPicture: [], detections: [], scalpPositions: "ScalpFull", appointmentPoint: 100, applyPoint: 100, consumePoint: 100, exercisePoint: 100, otherPoint: 100)
            
            var comparisonModels: [TrackProgressModel] = []
            
            for i in models{
                if getMonth(from: i.dateTaken) == getMonth(from: weekDate) {
                    comparisonModels.append(i)
                }
            }
            print("JUMLAH MODELS: \(comparisonModels.count)")
            
            modelA = comparisonModels[0]
            
            modelB = comparisonModels[comparisonModels.count - 1]
            
            modelScalpPositions = modelA.scalpPositions
            
            detectionsA = modelA.detections
            detectionsB = modelB.detections
            
            if modelA.scalpPositions == modelB.scalpPositions{
                let heatMapArrayA = createArrayHeatMap(detections: detectionsA, scalpPositions: modelScalpPositions)
                let heatMapArrayB = createArrayHeatMap(detections: detectionsB, scalpPositions: modelScalpPositions)
                
                heatMapArray = differenceBetweenArrays(arrayA: heatMapArrayB, arrayB: heatMapArrayA)!
            }
            
            let totalAverageHairA = totalAverageHair(targetObjectDetection: detectionsA)
            let totalAverageHairB = totalAverageHair(targetObjectDetection: detectionsB)
            
            if totalAverageHairB - totalAverageHairA <= totalAverageHairA/10{
                // INI CUMAN PERUBAHAN 10%, COUNT IT AS NO BIG PROGRESS
                hairGrowthStatus = "doing OK"
            } else if totalAverageHairB > totalAverageHairA {
                hairGrowthStatus = "amazing"
            } else {
                hairGrowthStatus = "can be better"
            }

            
            setSuggestions(models: models)
            
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
        print("targetObjectDetection: \(targetObjectDetection.count)")
        print("totalObjects: \(totalObjects)")
        print("totalLabels: \(totalLabels)")
        
        // Calculate the average, ensuring to handle division by zero
        let average = totalObjects > 0 ? Double(totalLabels) / Double(totalObjects) : 0.0
        //print("Average: \(average)")
        return average
    }
    
    // Function to get the month from a Date
    func getMonth(from date: Date) -> Int {
        let calendar = Calendar.current // Get the current calendar
        let components = calendar.dateComponents([.month], from: date) // Extract month component
        return components.month ?? 0 // Return month or 0 if nil
    }
    
    func differenceBetweenArrays(arrayA: [Float], arrayB: [Float]) -> [Float]? {
        // Check if both arrays have the same count
        guard arrayA.count == arrayB.count else {
            return nil // Return nil if the arrays do not have the same length
        }
        
        // Create a new array to hold the differences
        var differences: [Float] = []
        
        // Iterate through both arrays and calculate the difference
        for i in 0..<arrayA.count {
            var difference = arrayA[i] - arrayB[i] // Calculate the difference
            difference = difference/2 + 0.5
            differences.append(difference) // Add the difference to the new array
        }
        
        return differences // Return the array of differences
    }
    
    func setSuggestions(models: [TrackProgressModel]){
        let applyPoints = models.compactMap{$0.applyPoint}
        let appointmentPoints = models.compactMap{$0.appointmentPoint}
        let consumePoints = models.compactMap{$0.consumePoint}
        let exercisePoints = models.compactMap{$0.exercisePoint}
        let otherPoints = models.compactMap{$0.otherPoint}
        
        let okThreshold = 85.00
        
        let applyAvg = averagePoints(of: applyPoints)
        let appointmentAvg = averagePoints(of: appointmentPoints)
        let consumeAvg = averagePoints(of: consumePoints)
        let exerciseAvg = averagePoints(of: exercisePoints)
        let otherAvg = averagePoints(of: otherPoints)
        
        print("applyAvg: \(applyAvg)")
        
        if applyAvg <= okThreshold{
            applySuggestion = false
        }
        
        if appointmentAvg <= okThreshold{
            appointmentSuggestion = false
        }
        
        if consumeAvg <= okThreshold{
            consumeSuggestion = false
        }
        
        if exerciseAvg <= okThreshold{
            exerciseSuggestion = false
        }
        
        if otherAvg <= okThreshold{
            otherSuggestion = false
        }
    }
    
    func averagePoints(of array: [Int]) -> Double {
        guard !array.isEmpty else { return 0.0 } // Check if array is empty
        
        let sum = array.reduce(0, +)
        
        return Double(sum) / Double(array.count)
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
        print("scalpPositions: \(scalpPositions)")
        
        let currentPositions = optionsDict[scalpPositions]
        
        print("currentPositions: \(currentPositions)")

        
        return currentPositions!
    }
    
    func createArrayHeatMap(detections: [[DetectedObject]], scalpPositions: String) -> [Float] {
        var arrayToReturn : [Float] = []
        var averageToAppend = 1.0
        var validNumbers = [0, 1, 2, 3, 4, 5, 9, 10, 14, 15, 19, 20, 24, 25, 26, 27, 28, 29]
        var toAppend: [Int] = []
        
        if processCurrentScalpPositions(scalpPositions: scalpPositions).count == 6{
            print("Scalp Positions: \(scalpPositions)")
            let stringToIntArray: [String: [Int]] = [
                "B. Left Side": [7, 8, 13, 18, 22, 23],
                "C. Right Side": [6, 7, 11, 16, 21, 22],
                "D. Front Side": [16, 17, 18, 21, 22, 23],
                "E. Middle Side": [11, 12, 13, 21, 22, 23],
                "F. Back Side": [6, 7, 8, 11, 12, 13],
            ]
            toAppend = stringToIntArray[scalpPositions]!
            print("toAppend: \(toAppend)")
            
            //validNumbers.append(contentsOf: toAppend)
            validNumbers += toAppend
            validNumbers.sort(by: <)
            print("---------------")
            print("VALID NUMBERS: \(validNumbers)")
            print("---------------")
        }
        
        var indexDetections = 1
        for i in 0...29{
            //find where the index out of bounds is
            //print("Current Index: \(i)")
            
            if validNumbers.contains(i) {
                arrayToReturn.append(1.0)
            } else {
                print("----------------------")
                print(reverseConvertNumber(i)! + 1)
                //print(detections[reverseConvertNumber(i)! + 1])
                //averageToAppend = sequentialAverageHair(targetObjectDetection: detections[reverseConvertNumber(i)! + 1])
                averageToAppend = sequentialAverageHair(targetObjectDetection: detections[indexDetections])
                indexDetections += 1
                if averageToAppend >= 3.0 {
                    averageToAppend = 3.0
                }
                averageToAppend = (averageToAppend - 1.0) / (3.0 - 1.0)
                
                arrayToReturn.append(Float(averageToAppend))
            }
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


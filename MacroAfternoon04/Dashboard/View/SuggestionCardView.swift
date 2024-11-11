//
//  SuggestionCardView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 01/11/24.
//

import SwiftUI
import SwiftData

struct SuggestionCardView: View {
    @Query private var models: [TrackProgressModel]
    @State var applySuggestion = true
    @State var appointmentSuggestion = true
    @State var consumeSuggestion = true
    @State var exerciseSuggestion = true
    @State var otherSuggestion = true
    
    @State var sleepData = ""
    @State var movementData = ""
    
    @EnvironmentObject var healthViewModel: HealthViewModel

    
    var body: some View {
        VStack(alignment: .center){
            Text("Your hair growth is")
                .font(.title2)
            Text("getting better")
                .font(.largeTitle)
        }
        .frame(width: UIScreen.main.bounds.width * 340 / 430)
        .padding(.vertical)
        .onAppear{
            let calendar = Calendar.current
            let startDate = calendar.date(byAdding: .day, value: -1, to: Date())!
            healthViewModel.calculateAverageSleep(startDate: startDate, endDate: Date())
            healthViewModel.calculateAverageMovement(startDate: startDate, endDate: Date())
            
            sleepData = String(format: "%.1f", healthViewModel.averageSleep)
            movementData = String(format: "%.1f", healthViewModel.averageMovement)
        }
        
        if Int(sleepData)! <= 6{
            HStack{
                Text("·")
                Text("Have more sleep time")
            }
        }
        
        if Int(movementData)! <= 2000 {
            HStack{
                Text("·")
                Text("Daily workout is recommended")
            }
        }
        HStack{
            Text("·")
            Text("Be more consistent with applying serum")
        }
        .isHidden(applySuggestion, remove: applySuggestion)
        
        HStack{
            Text("·")
            Text("Be more consistent with your appointments")
        }
        .isHidden(appointmentSuggestion, remove:appointmentSuggestion)

        HStack{
            Text("·")
            Text("Be more consistent with consuming medication")
        }
        .isHidden(consumeSuggestion, remove:consumeSuggestion)
        
        HStack{
            Text("·")
            Text("Be more consistent with your exercises")
        }
        .isHidden(exerciseSuggestion, remove: exerciseSuggestion)

    }
    
    // Function to get the month from a Date
    func getMonth(from date: Date) -> Int {
        let calendar = Calendar.current // Get the current calendar
        let components = calendar.dateComponents([.month], from: date) // Extract month component
        return components.month ?? 0 // Return month or 0 if nil
    }
    
    private func weekOfMonth(for date: Date) -> Int {
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
        return weekOfMonth
    }
    
    func setSuggestions(){
        var lastMonthModels: [TrackProgressModel] = []
        
        var lastMonth = getMonth(from: models[models.count - 1].dateTaken)
        var allMonths: [Int] = []
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: models[models.count - 1].dateTaken)
        
        if day >= 28{
            if weekOfMonth(for: Date()) != weekOfMonth(for: models[models.count - 1].dateTaken){
               lastMonth -= 1
            }
        } else {
            lastMonth -= 1
        }
        
        for model in models{
            if !allMonths.contains(getMonth(from: model.dateTaken)){
                allMonths.append(getMonth(from: model.dateTaken))
            }
                        
            if getMonth(from: model.dateTaken) == lastMonth{
                lastMonthModels.append(model)
            }
        }
        
        let applyPoints = lastMonthModels.compactMap{$0.applyPoint}
        let appointmentPoints = lastMonthModels.compactMap{$0.appointmentPoint}
        let consumePoints = lastMonthModels.compactMap{$0.consumePoint}
        let exercisePoints = lastMonthModels.compactMap{$0.exercisePoint}
        let otherPoints = lastMonthModels.compactMap{$0.otherPoint}
        
        let okThreshold = 85.00
        
        let applyAvg = averagePoints(of: applyPoints)
        let appointmentAvg = averagePoints(of: appointmentPoints)
        let consumeAvg = averagePoints(of: consumePoints)
        let exerciseAvg = averagePoints(of: exercisePoints)
        let otherAvg = averagePoints(of: otherPoints)
                
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
}

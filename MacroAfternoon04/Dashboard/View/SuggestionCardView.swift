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
    
    var body: some View {
        VStack(alignment: .center){
            Text("Your hair growth is")
                .font(.title2)
            Text("getting better")
                .font(.largeTitle)
        }
        .frame(width: UIScreen.main.bounds.width * 340 / 430)
        .padding(.vertical)
        
        HStack{
            Text("·")
            Text("Have more sleep time")
        }
        
        HStack{
            Text("·")
            Text("Reduce your stress")
        }
        
        HStack{
            Text("·")
            Text("Start more workouts")
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
        
        //CARI TAHU SAMA TIM, APA KETENTUAN ITU BULAN APA YANG BISA DITARUH DI DASHBOARD
        let lastMonth = getMonth(from: models[models.count - 1].dateTaken)
        var allMonths: [Int] = []
        
        //if models[models.count - 1].dateTaken.da
        
        
        for model in models{
            if !allMonths.contains(getMonth(from: model.dateTaken)){
                allMonths.append(getMonth(from: model.dateTaken))
            }
            
            //HOW TO SET LASTMONTH AS EITHER ONE MONTH PRIOR OR WHEN ITS ALREADY THE LAST REPORT OF THE MONTH
            
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
}

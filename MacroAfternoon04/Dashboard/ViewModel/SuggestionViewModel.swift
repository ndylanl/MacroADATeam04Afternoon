//
//  SuggestionViewModel.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 06/11/24.
//

import Foundation
import SwiftUI


class SuggestionViewModel: ObservableObject {
    @EnvironmentObject var healthViewModel: HealthViewModel

    @Published var suggestions: [String] = []
    
    func calculateAverageHealthData() {
        let calendar = Calendar.current
        let endDate = Date()
        let startDate = calendar.date(byAdding: .day, value: -7, to: endDate)!
        
        // Panggil fungsi untuk menghitung rata-rata data kesehatan
        healthViewModel.calculateAverageSleep(startDate: startDate, endDate: endDate)
        healthViewModel.calculateAverageMovement(startDate: startDate, endDate: endDate)
        healthViewModel.calculateAverageHeartRate(startDate: startDate, endDate: endDate)
        
        updateSuggestions()
    }
    
    func updateSuggestions() {
        suggestions = [] // Clear existing suggestions
        
        if healthViewModel.averageSleep < 7.0 {
            suggestions.append("• Have more sleep time")
        }
        if healthViewModel.averageMovement < 100 {
            suggestions.append("• Start more workouts")
        }
        
    }
}

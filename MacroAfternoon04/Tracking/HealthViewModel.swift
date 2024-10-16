//
//  HealthViewModel.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 15/10/24.
//

import Foundation
import HealthKit

class HealthViewModel: ObservableObject {
    private var healthKitManager = HealthManager()
    
    @Published var sleepData: [HKCategorySample] = []
    @Published var movementData: [HKQuantitySample] = []
    @Published var heartRateData: [HKQuantitySample] = []
    @Published var isAuthorized = false
    
    @Published var totalMovementToday: Double = 0.0
    private var timer: Timer?
//    
//    init() {
//       // calculateTotalMovementToday()
//        //setupDailyResetTimer()
//    }
    
    func healthRequest() {
        Task {
            await healthKitManager.requestAuthorization()  // Use async/await for authorization
            self.changeAuthorizationStatus()
            self.fetchHealthData()
        }
    }
    
    func fetchHealthData() {
        // Fetch sleep data
        healthKitManager.fetchSleepData { data, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.sleepData = data
                }
            }
        }
        
        // Fetch movement data (active energy burned)
        healthKitManager.fetchMovementData { data, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.movementData = data
                    self.calculateTotalMovementToday()
                }
            }
        }
        
        // Fetch heart rate data
        healthKitManager.fetchHeartRateData { data, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.heartRateData = data
                    
                }
            }
        }
    }
    
    func changeAuthorizationStatus() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        let status = healthKitManager.healthStore?.authorizationStatus(for: heartRateType)
        
        switch status {
        case .notDetermined:
            isAuthorized = false
        case .sharingDenied:
            isAuthorized = false
        case .sharingAuthorized:
            isAuthorized = true
        @unknown default:
            isAuthorized = false
        }
    }
    
    // Calculate total movement for today
        func calculateTotalMovementToday() {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())

            let totalMovement = movementData
                .filter { calendar.isDate($0.startDate, inSameDayAs: today) } // Filter by today's date
                .reduce(0) { total, sample in
                    total + sample.quantity.doubleValue(for: .kilocalorie())
                }
            
            totalMovementToday = totalMovement
            print("Total Movement Today: \(movementData)")
        }

        // Setup timer to reset the total at midnight (00:00)
//        func setupDailyResetTimer() {
//            let calendar = Calendar.current
//            let now = Date()
//            
//            // Calculate the next midnight time
//            let nextMidnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0), matchingPolicy: .nextTime)!
//            
//            // Calculate time interval until the next midnight
//            let timeIntervalUntilMidnight = nextMidnight.timeIntervalSince(now)
//            
//            // Schedule the timer
//            timer = Timer.scheduledTimer(withTimeInterval: timeIntervalUntilMidnight, repeats: false) { [weak self] _ in
//                // Reset the total movement at midnight
//                self?.totalMovementToday = 0.0
//                
//                // Recalculate movement throughout the new day
//                self?.setupDailyResetTimer() // Schedule again for the next day
//            }
//        }
}

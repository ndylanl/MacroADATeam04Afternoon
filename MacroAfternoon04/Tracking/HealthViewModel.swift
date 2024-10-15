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
}

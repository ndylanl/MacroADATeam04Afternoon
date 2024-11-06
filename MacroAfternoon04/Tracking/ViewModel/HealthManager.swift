//
//  HealthManager.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 14/10/24.
//

import Foundation
import HealthKit
import Observation

enum HealthManagerError: Error {
    case healthStoreNotAvailable
}

@Observable
class HealthManager {
    
//    var healthStore: HKHealthStore?
     let healthStore = HKHealthStore()
//    var lastError: Error?
    
//    init() {
//        if HKHealthStore.isHealthDataAvailable() {
//            healthStore = HKHealthStore()
//        } else  {
//            lastError = HealthManagerError.healthStoreNotAvailable
//        }
//    }
    
//    func requestAuthorization() async {
//        guard let movement = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
//        guard let sleep = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis) else { return }
//        guard let heartRate = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }
//        guard let healthStore else { return }
//        
//        let healthTypes: Set<HKSampleType> = [movement, sleep, heartRate]
//        
//        do {
//            try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
//        } catch {
//            lastError = error
//        }
//    }
    
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        let healthDataToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]
        
        healthStore.requestAuthorization(toShare: [], read: healthDataToRead) { success, error in
            if success {
                print("HealthKit authorization granted.")
            } else {
                print("HealthKit authorization denied.")
            }
        }
    }

    // Fetch sleep data
    func fetchSleepData(completion: @escaping ([HKCategorySample]?, Error?) -> Void) {
        guard let sleepType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
            completion(results as? [HKCategorySample], error)
        }
        
        healthStore.execute(query)
    }
    
    // Fetch movement (active energy burned) data
    func fetchMovementData(completion: @escaping ([HKQuantitySample]?, Error?) -> Void) {
        guard let activeEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        
        let query = HKSampleQuery(sampleType: activeEnergyType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
            completion(results as? [HKQuantitySample], error)
        }
        
        healthStore.execute(query)
    }
    
    // Fetch heart rate data
    func fetchHeartRateData(completion: @escaping ([HKQuantitySample]?, Error?) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }
        
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
            completion(results as? [HKQuantitySample], error)
        }
        
        healthStore.execute(query)
    }
}

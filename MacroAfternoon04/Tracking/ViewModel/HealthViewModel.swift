//
//  HealthViewModel.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 15/10/24.
//

import Foundation
import HealthKit

@MainActor
class HealthViewModel: ObservableObject {
    private var healthKitManager = HealthManager()
    
    @Published var sleepData: [HKCategorySample] = []
    @Published var movementData: [HKQuantitySample] = []
    @Published var heartRateData: [HKQuantitySample] = []
    @Published var isAuthorized = false
    
    @Published var totalMovementToday: Double = 0.0
    private var timer: Timer?
    
    @Published var averageSleep: Double = 0.0
    @Published var averageMovement: Double = 0.0
    @Published var averageHeartRate: Double = 0.0
    
    
    init() {
        self.healthRequest()
    }
    
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

        DispatchQueue.main.async {
            switch status {
            case .notDetermined:
                self.isAuthorized = false
            case .sharingDenied:
                self.isAuthorized = false
            case .sharingAuthorized:
                self.isAuthorized = true
            case .none:
                break
            @unknown default:
                self.isAuthorized = false
            }
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
//        print("Total Movement Today: \(movementData)")
    }
    
    func calculateAverageSleep(startDate: Date, endDate: Date) {
        // Filter sleep data dalam jangka waktu yang ditentukan
        let filteredSleepData = sleepData.filter { sample in
            return sample.startDate >= startDate && sample.endDate <= endDate
        }

        // Hitung total durasi tidur dalam detik
        let totalSleepDuration = filteredSleepData.reduce(0) { total, sample in
            return total + sample.endDate.timeIntervalSince(sample.startDate)
        }

        // Hitung jumlah hari unik dari data tidur
        let uniqueDays = Set(filteredSleepData.map { Calendar.current.startOfDay(for: $0.startDate) }).count

        // Hitung rata-rata durasi tidur dalam jam
        let averageSleep: Double
        if uniqueDays > 0 {
            averageSleep = totalSleepDuration / Double(uniqueDays) / 3600 // konversi ke jam
        } else {
            averageSleep = 0 // atau nilai default lainnya jika tidak ada hari
        }
        
//        // Update nilai rata-rata tidur
//        self.averageSleep = averageSleep
//        print("NOTICE ME :D")
////        print(filteredSleepData)
//        print(totalSleepDuration)
//        print(averageSleep)

    }
    
    func calculateAverageMovement(startDate: Date, endDate: Date) {
        // Filter movement data within the specified time range
        let filteredMovementData = movementData.filter { sample in
            return sample.startDate >= startDate && sample.endDate <= endDate
        }

        // Calculate total calories burned
        let totalMovement = filteredMovementData.reduce(0) { total, sample in
            return total + sample.quantity.doubleValue(for: .kilocalorie())
        }

        // Calculate the number of unique days with recorded movement data
        let uniqueDays = Set(filteredMovementData.map { Calendar.current.startOfDay(for: $0.startDate) })

        // Calculate average movement based on total movement and unique days
        let averageMovement = uniqueDays.count > 0 ? totalMovement / Double(uniqueDays.count) : 0

        
        // Update nilai rata-rata gerakan
        self.averageMovement = averageMovement

    }
    
    func calculateAverageHeartRate(startDate: Date, endDate: Date) {
        // Filter heart rate data dalam jangka waktu yang ditentukan
        let filteredHeartRateData = heartRateData.filter { sample in
            return sample.startDate >= startDate && sample.endDate <= endDate
        }
        
        // Hitung rata-rata detak jantung
        let totalHeartRate = filteredHeartRateData.reduce(0) { total, sample in
            return total + sample.quantity.doubleValue(for: .count().unitDivided(by: .minute()))
        }
        
        let averageHeartRate = totalHeartRate / Double(filteredHeartRateData.count)
        
        // Update nilai rata-rata detak jantung
        self.averageHeartRate = averageHeartRate


    }

}


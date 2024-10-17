//
//  HealthView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 15/10/24.
//

import SwiftUI

struct HealthView: View {
    @ObservedObject var healthViewModel = HealthViewModel()
    
    var body: some View {
        
        
        AnyLayout(HStackLayout()){

            
            VStack(alignment: .leading) {
                // Tampilan untuk rata-rata tidur
                HStack {
                    Text(String(format: "%.1f", healthViewModel.averageSleep))
                        .font(.title)
                    Text("hrs")
                        .font(.body)
                }
                Text("🌙 Sleep Time")
                    .font(.footnote)
                
                // Tampilan untuk rata-rata gerakan (kalori terbakar)
                HStack {
                    Text(String(format: "%.0f", healthViewModel.averageMovement))
                        .font(.title)
                    Text("kcal")
                        .font(.body)
                }
                Text("🔥 Movement")
                    .font(.footnote)
                
                // Tampilan untuk rata-rata detak jantung
                HStack {
                    Text(String(format: "%.0f", healthViewModel.averageHeartRate))
                        .font(.title)
                    Text("bpm")
                        .font(.body)
                }
                Text("💓 Heart Rate")
                    .font(.footnote)
            }
        }
        .onAppear {
            // Set the date range to calculate the averages
            let calendar = Calendar.current
            let endDate = Date()
            let startDate = calendar.date(byAdding: .day, value: -7, to: endDate)!
            
            // Panggil fungsi untuk menghitung rata-rata data kesehatan
            healthViewModel.calculateAverageSleep(startDate: startDate, endDate: endDate)
            healthViewModel.calculateAverageMovement(startDate: startDate, endDate: endDate)
            healthViewModel.calculateAverageHeartRate(startDate: startDate, endDate: endDate)
            

            
        }
        
        
        
        //        VStack {
        //            Text("Health Data Dashboard")
        //                .font(.title)
        //                .padding()
        
        //            // Display Sleep Data
        //            if !healthViewModel.sleepData.isEmpty {
        //                VStack(alignment: .leading) {
        //                    Text("Sleep Data:")
        //                        .font(.headline)
        //                    ForEach(healthViewModel.sleepData, id: \.uuid) { sleepSample in
        //                        Text("Sleep Date: \(formatDate(sleepSample.startDate))")
        //                    }
        //                }.padding()
        //            }
        //
        //            // Display Movement (Active Energy Burned) Data
        //            if !healthViewModel.movementData.isEmpty {
        //                VStack(alignment: .leading) {
        //                    Text("Active Energy Burned Data:")
        //                        .font(.headline)
        //                    ForEach(healthViewModel.movementData, id: \.uuid) { movementSample in
        //                        let energyBurned = movementSample.quantity.doubleValue(for: .kilocalorie())
        //                        Text("Energy Burned: \(String(format: "%.2f", energyBurned)) kcal")
        //                    }
        //                }.padding()
        //            }
        //
        //            // Display Heart Rate Data
        //            if !healthViewModel.heartRateData.isEmpty {
        //                VStack(alignment: .leading) {
        //                    Text("Heart Rate Data:")
        //                        .font(.headline)
        //                    ForEach(healthViewModel.heartRateData, id: \.uuid) { heartRateSample in
        //                        let heartRate = heartRateSample.quantity.doubleValue(for: .count().unitDivided(by: .minute()))
        //                        Text("Heart Rate: \(String(format: "%.0f", heartRate)) bpm")
        //                    }
        //                }.padding()
        //            }
        //
        //            Spacer()
        //        }
        //        .task {
        //            healthViewModel.healthRequest()
        //        }
        //    }
        
        //    // Helper function to format dates
        //    private func formatDate(_ date: Date) -> String {
        //        let formatter = DateFormatter()
        //        formatter.dateStyle = .medium
        //        return formatter.string(from: date)
    }
}

#Preview {
    HealthView()
}

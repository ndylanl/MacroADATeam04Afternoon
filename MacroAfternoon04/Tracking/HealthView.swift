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
    }
}

#Preview {
    HealthView()
}

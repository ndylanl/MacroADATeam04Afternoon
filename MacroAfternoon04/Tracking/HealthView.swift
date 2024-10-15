import SwiftUI

struct HealthView: View {
    @ObservedObject var healthViewModel = HealthViewModel()

    var body: some View {
        VStack {
            Text("Latest Health Data")
                .font(.title)
                .padding()

            // Display latest Sleep Data
            if let latestSleep = healthViewModel.sleepData.last {
                VStack(alignment: .leading) {
                    Text("Latest Sleep Data:")
                        .font(.headline)
                    Text("Sleep Date: \(formatDate(latestSleep.startDate))")
                }
                .padding()
            }

            // Display latest Movement (Active Energy Burned) Data
            if let latestMovement = healthViewModel.movementData.last {
                VStack(alignment: .leading) {
                    Text("Latest Active Energy Burned:")
                        .font(.headline)
                    let energyBurned = latestMovement.quantity.doubleValue(for: .kilocalorie())
                    Text("Energy Burned: \(String(format: "%.2f", energyBurned)) kcal")
                }
                .padding()
            }

            // Display latest Heart Rate Data
            if let latestHeartRate = healthViewModel.heartRateData.last {
                VStack(alignment: .leading) {
                    Text("Latest Heart Rate:")
                        .font(.headline)
                    let heartRate = latestHeartRate.quantity.doubleValue(for: .count().unitDivided(by: .minute()))
                    Text("Heart Rate: \(String(format: "%.0f", heartRate)) bpm")
                }
                .padding()
            }

            Spacer()
        }
        .task {
            healthViewModel.healthRequest()
        }
    }

    // Helper function to format dates
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    HealthView()
}

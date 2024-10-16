//
//  YourActivityCardView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 09/10/24.
//

import SwiftUI

struct YourActivityCardView: View {
    @ObservedObject var healthViewModel = HealthViewModel() // Integrasi HealthViewModel
    
    var body: some View {
        ZStack(){
            Image("placeholderDashboardYourActivityCard")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 18))
            
            VStack(alignment: .leading){
                Text("Your Activity")
                    .font(.footnote)
                
                Divider()
                
                AnyLayout(HStackLayout()){
                    // Menampilkan data Sleep dari healthViewModel
                    VStack(alignment: .leading){
                        
                        
                        if let sleepSample = healthViewModel.sleepData.first(where: {
                            Calendar.current.isDate($0.endDate, inSameDayAs: Date()) //ambil data yang end date nya hari ini
                        }) {
                            let sleepDuration = sleepSample.endDate.timeIntervalSince(sleepSample.startDate) / 3600 // convert to hours
                            HStack{
                                Text(String(format: "%.1f", sleepDuration))
                                    .font(.title)
                                Text("hrs")
                                    .font(.subheadline)
                            }
                            Text("🌙 Sleep Time")
                                .font(.caption2)
                        } else {
                            // Placeholder if no data for today
                            HStack{
                                Text("--")
                                    .font(.title)
                                Text("hrs")
                                    .font(.subheadline)
                            }
                            Text("🌙 Sleep Time")
                                .font(.caption2)
                        }
                        
                    }
                    Spacer()
                    
                    // Menampilkan data Heart Rate dari healthViewModel
                    VStack(alignment: .leading){
                        if let heartRateSample = healthViewModel.heartRateData.last {
                            let heartRate = heartRateSample.quantity.doubleValue(for: .count().unitDivided(by: .minute()))
                            HStack{
                                Text(String(format: "%.0f", heartRate))
                                    .font(.title)
                                Text("bpm")
                                    .font(.subheadline)
                            }
                            Text("❤️ Heart Rate")
                                .font(.caption2)
                        } else {
                            // Placeholder jika tidak ada data heart rate
                            HStack{
                                Text("--")
                                    .font(.title)
                                Text("bpm")
                                    .font(.subheadline)
                            }
                            Text("❤️ Heart Rate")
                                .font(.caption2)
                        }
                    }
                    Spacer()
                    
                    // Menampilkan data Movement dari healthViewModel
                    VStack(alignment: .leading){
                        if !healthViewModel.movementData.isEmpty {
                            // Hanya menampilkan total movement hari ini
                            HStack {
                                Text(String(format: "%.2f", healthViewModel.totalMovementToday))
                                    .font(.title)
                                Text("kcal")
                                    .font(.subheadline)
                            }
                            Text("🏃 Movement")
                                .font(.caption2)
                        } else {
                            // Placeholder jika tidak ada data movement
                            HStack {
                                Text("--")
                                    .font(.title)
                                Text("kcal")
                                    .font(.subheadline)
                            }
                            Text("🏃 Movement")
                                .font(.caption2)
                        }
                    }
                }
                
                ZStack{
                    RoundedCornerComponentView()
                    
                    VStack(alignment: .leading){
                        Text("💡 Tips")
                            .font(.subheadline)
                        Text("Apply shampoo to your scalp, instead of the entire length of your hair. This way, you cleanse and wash away built-up products, dead skin, and excess oil, but avoid drying your hair too much.")
                            .font(.body)
                    }.padding(12)
                }
                .frame(width: cardWidthSize() - 32, height: UIScreen.main.bounds.height * 159 / 985)
            }
            .frame(width: cardWidthSize()-32, alignment: .center)
        }
        .frame(width: cardWidthSize(), height: cardHeightSize())
        .task {
            healthViewModel.healthRequest() // Meminta data kesehatan saat tampilan muncul
        }
    }
    
    func cardWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 374 / 430)
    }
    
    func cardHeightSize() ->CGFloat{
        (UIScreen.main.bounds.height * 309 / 985)
    }
}

#Preview {
    YourActivityCardView()
}

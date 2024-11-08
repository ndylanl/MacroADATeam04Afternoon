//
//  YourActivityCardView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 09/10/24.
//

import SwiftUI

struct YourActivityCardView: View {
    @EnvironmentObject var healthViewModel: HealthViewModel // Integrasi HealthViewModel
    
    var body: some View {
        ZStack(){
            RoundedCornerComponentView()
            //            Image("placeholderDashboardYourActivityCard")
            //                .resizable()
            //                .clipShape(RoundedRectangle(cornerRadius: 18))
            
            VStack(alignment: .leading){
                Text("Last Result & Activity")
                    .font(.body)
                
                Divider()
                
                
                Text("You have no monthly results yet.")
                    .padding([.top, .bottom, .trailing])
                    .font(.title3)
                    .foregroundStyle(Color("NeutralColor"))
                
                AnyLayout(HStackLayout()){
                    //                HStack{
                    VStack(alignment: .leading){
                        
                        if !healthViewModel.sleepData.isEmpty {
                            // Ambil semua sleepSample yang endDate-nya pada hari ini

                            let totalSleepDuration = healthViewModel.sleepData
                                .filter {
                                    Calendar.current.isDate($0.endDate, inSameDayAs: Date()) // Ambil data yang end date-nya hari ini
                                }
                                .reduce(0) { total, sample in
                                    return total + sample.endDate.timeIntervalSince(sample.startDate) // Hitung total durasi
                                }
                            
                            // Konversi total durasi tidur dari detik ke jam
                            let sleepDurationInHours = totalSleepDuration / 3600
                            
                            HStack {
                                Text(String(format: "%.1f", sleepDurationInHours))
                                    .font(.title)
                                Text("hrs")
                                    .font(.subheadline)
                            }
                            HStack{
                                Image(systemName: "moon.stars.fill")
                                Text("Sleep")
                            }
                            .font(.footnote)
     
                            
                        } else {
                            // Placeholder jika tidak ada data tidur untuk hari ini
                            HStack {
                                Text("--")
                                    .font(.title)
                                Text("hrs")
                                    .font(.subheadline)
                            }
                            HStack{
                                Image(systemName: "moon.stars.fill")
                                Text("Sleep")
                            }
                            .font(.footnote)
                            
                        }
                    }
                    .frame(width: cardActivityWidthSize(), height: cardActivityHeightSize())
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 0.5))
                    
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
                            HStack{
                                Image(systemName: "heart.fill")
                                Text("Heart rate")
                            }
                            .font(.footnote)
                        } else {
                            // Placeholder jika tidak ada data heart rate
                            HStack{
                                Text("--")
                                    .font(.title)
                                Text("bpm")
                                    .font(.subheadline)
                            }
                            HStack{
                                Image(systemName: "heart.fill")
                                Text("Heart rate")
                            }
                            .font(.footnote)
                        }
                    }
                    .frame(width: cardActivityWidthSize(), height: cardActivityHeightSize())
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 0.5))
                    
                    Spacer()
                    
                    // Menampilkan data Movement dari healthViewModel
                    VStack(alignment: .leading){
                        if !healthViewModel.movementData.isEmpty {
                            // Hanya menampilkan total movement hari ini
                            HStack {
                                Text(String(format: "%.1f", healthViewModel.totalMovementToday))
                                    .font(.title)
                                Text("kcal")
                                    .font(.subheadline)
                            }
                            HStack{
                                Image(systemName: "waveform.path.ecg")
                                Text("Movement")
                            }
                            .font(.footnote)
                        } else {
                            // Placeholder jika tidak ada data movement
                            HStack {
                                Text("--")
                                    .font(.title)
                                Text("kcal")
                                    .font(.subheadline)
                            }
                            HStack{
                                Image(systemName: "waveform.path.ecg")
                                Text("Movement")
                            }
                            .font(.footnote)
                        }
                    }
                    .frame(width: cardActivityWidthSize(), height: cardActivityHeightSize())
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 0.5))
                }
                
            }
            .onAppear {
                healthViewModel.fetchHealthData()
            }
            
            .frame(width: cardWidthSize()-32, alignment: .center)
        }
        .frame(width: cardWidthSize(), height: cardHeightSize())
        //        .task {
        //            healthViewModel.healthRequest() // Meminta data kesehatan saat tampilan muncul
        //        }
    }
    func cardActivityWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 111 / 430)
    }
    
    func cardActivityHeightSize() -> CGFloat{
        (UIScreen.main.bounds.height * 79 / 932)
    }
    
    func cardWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 374 / 430)
    }
    
    func cardHeightSize() ->CGFloat{
        (UIScreen.main.bounds.height * 219 / 964)
    }
}

#Preview {
    YourActivityCardView()
}

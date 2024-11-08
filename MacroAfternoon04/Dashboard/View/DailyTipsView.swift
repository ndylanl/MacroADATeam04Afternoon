//
//  DailyTipsView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 31/10/24.
//

import SwiftUI

struct DailyTipsView: View {
    let tips = TipsMessages.tips
    @State private var currentTipIndex = 0
    @State private var timer: Timer?

    var body: some View {
        ZStack{
            RoundedCornerComponentView()
            
            VStack(alignment: .leading){
                Text("Daily Tips")
                    .font(.body)
                    .padding(.bottom, 5)
                
                Divider()

                Text(tips[currentTipIndex])
                    .font(.body)
                    
                
            }
            .onAppear {
                startTimer()

            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width * 374 / 430)
        
    }


    
    private func startTimer() {
            // Mengatur timer untuk mengganti tips setiap 20 detik
            timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
                showNextTip()
            }
        }

    private func showNextTip() {
        // Mengganti indeks tip
        currentTipIndex = (currentTipIndex + 1) % tips.count
    }
}

struct DailyTipsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyTipsView()
    }
}

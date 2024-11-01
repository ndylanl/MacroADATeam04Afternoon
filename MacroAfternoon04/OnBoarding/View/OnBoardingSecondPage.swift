//
//  OnBoardingFirstPage.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 31/10/24.
//

import SwiftUI

struct OnBoardingSecondPageView: View {
    
    @Binding var isOnBoardingComplete: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Sleep, Stress, and Movement Detection")
                .font(.title)
            
            Text("For more personalized experience, access to Apple Health is required to detect your activities.")
                .font(.body)
                .padding(.vertical)
            
            HStack{
                Image("Option")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 253 / 430, height: UIScreen.main.bounds.width * 253 / 430)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 100)
            
            Spacer()
            
            Button{
                isOnBoardingComplete = true
                UserDefaults.standard.set(isOnBoardingComplete, forKey: "isOnBoardingComplete")
            } label: {
                Text("Start Tracking Hair Growth")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .foregroundStyle(Color("SecondaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button{
                isOnBoardingComplete = true
                UserDefaults.standard.set(isOnBoardingComplete, forKey: "isOnBoardingComplete")
            } label: {
                Text("Skip")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(Color("PrimaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        .background(
            LinearGradient(colors: [Color("SecondaryColor"), .white], startPoint: .bottom, endPoint: .top)
        )
    }
}

#Preview {
    OnBoardingSecondPageView(isOnBoardingComplete: .constant(false))
}

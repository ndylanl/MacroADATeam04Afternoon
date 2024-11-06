//
//  OnBoardingFirstPage.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 31/10/24.
//

import SwiftUI

struct OnBoardingSecondPageView: View {
    
    @Binding var isOnBoardingComplete: Bool
    
    @Binding var selectedDay: Int
    
    @State var navigateToThirdOnBoarding: Bool = false
    
    @State var healthManager = HealthManager()
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Sleep, Stress, and Movement Detection")
                .font(.title)
            
            Text("For more personalized experience, access to Apple Health is required to detect your activities.")
                .font(.body)
                .padding(.vertical)
            
            HStack{
                Image("OnBoardingSecond")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 253 / 430, height: UIScreen.main.bounds.width * 253 / 430)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 100)
            
            Spacer()
            
            Button{
                
                // Request Access for Health
                Task{
                    await healthManager.requestAuthorization()
                    //                }
                    
                    
                    // .....
                    let currentDay = Calendar.current.component(.weekday, from: Date())
                    selectedDay = currentDay
                    UserDefaults.standard.set(selectedDay, forKey: "selectedDay")
                    
                    navigateToThirdOnBoarding = true
                }

                
                
            } label: {
                Text("Enable Access Now")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .foregroundStyle(Color("SecondaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button{
//                isOnBoardingComplete = true
//                UserDefaults.standard.set(isOnBoardingComplete, forKey: "isOnBoardingComplete")
                
                let currentDay = Calendar.current.component(.weekday, from: Date())
                selectedDay = currentDay
                UserDefaults.standard.set(selectedDay, forKey: "selectedDay")
                
                print(selectedDay)
                
                navigateToThirdOnBoarding = true
            } label: {
                Text("Later on Settings")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(Color("PrimaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            .navigationDestination(isPresented: $navigateToThirdOnBoarding, destination: {
                OnBoardingThirdPageView(isOnBoardingComplete: $isOnBoardingComplete)
            })
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        .background(
            LinearGradient(colors: [Color("SecondaryColor"), .white], startPoint: .bottom, endPoint: .top)
        )
        .navigationBarHidden(true)
    }
}

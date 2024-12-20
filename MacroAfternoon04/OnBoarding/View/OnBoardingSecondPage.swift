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
                .font(.largeTitle)
                .frame(height: UIScreen.main.bounds.height * 100 / 932)
            
            Text("For more personalized experience, access to Apple Health is required to detect your activities.")
                .multilineTextAlignment(.leading)
                .font(.body)
                .frame(height: UIScreen.main.bounds.height * 120 / 932)
//                .padding(.vertical)
                
            
            HStack{
                Image("OnBoardingSecond")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 253 / 430, height: UIScreen.main.bounds.width * 253 / 430)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            Button{
                
                // Request Access for Health
                Task{
                    healthManager.requestAuthorization()
                    //                    if UserDefaults.standard.bool(forKey: "shouldRequestAuthorization") {
                    //                        healthManager.requestAuthorization()
                    //                    }
                    
                    let currentDay = Calendar.current.component(.weekday, from: Date())
                    selectedDay = currentDay
                    UserDefaults.standard.set(selectedDay, forKey: "selectedDay")
                    
                    navigateToThirdOnBoarding = true
                }
                
            } label: {
                Text("Continue")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .foregroundStyle(Color("SecondaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button{
                
                let currentDay = Calendar.current.component(.weekday, from: Date())
                selectedDay = currentDay
                UserDefaults.standard.set(selectedDay, forKey: "selectedDay")
                UserDefaults.standard.set(8, forKey: "selectedHour")
                UserDefaults.standard.set(0, forKey: "selectedMinute")
                
                print(selectedDay)
                
                navigateToThirdOnBoarding = true
            } label: {
//                Text("Later on Settings")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(Color("PrimaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .disabled(true)
            .navigationDestination(isPresented: $navigateToThirdOnBoarding, destination: {
                OnBoardingThirdPageView(isOnBoardingComplete: $isOnBoardingComplete)
            })
                        .onAppear {
                            // Set default to true if not already set
                            if UserDefaults.standard.object(forKey: "shouldRequestAuthorization") == nil {
                                UserDefaults.standard.set(true, forKey: "shouldRequestAuthorization")
                            }
                        }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        .background(
            LinearGradient(colors: [Color("SecondaryColor"), .white], startPoint: .bottom, endPoint: .top)
        )
        .navigationBarHidden(true)
    }
    
}

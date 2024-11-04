//
//  OnBoardingFirstPage.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 31/10/24.
//

import SwiftUI

struct OnBoardingFirstPageView: View {
    
    @Binding var isOnBoardingComplete: Bool
    
    @Binding var showingAddProgressSheet: Bool
    
    @Binding var selectedDay: Int
    
    @State var navigateToSecondOnBoarding: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Track Your Hair Growth")
                    .font(.title)
                
                Text("Consistently")
                    .font(.title).bold()
                
                Text("Be motivated and well-reminded to maintain a good hair treatment journey.")
                    .font(.body)
                    .padding(.vertical)
                
                HStack{
                    Image(systemName: "camera.fill")
                        .font(.largeTitle)
                        .frame(width: UIScreen.main.bounds.width * 64 / 430 )
                    
                    VStack (alignment: .leading){
                        Text("Camera")
                            .bold()
                        
                        Text("take photos of your hair treatment progress every week to track changes.")
                            .opacity(0.7)
                    }
                }
                .padding(.vertical, 14)
                
                HStack{
                    Image(systemName: "bell.fill")
                        .font(.largeTitle)
                        .frame(width: UIScreen.main.bounds.width * 64 / 430 )
                    
                    VStack (alignment: .leading){
                        Text("Reminder")
                            .bold()
                        
                        Text("Set reminders for your medications, treatments, appointments, and others.")
                            .opacity(0.7)
                    }
                }
                .padding(.vertical, 14)
                
                HStack{
                    Image(systemName: "text.document.fill")
                        .font(.largeTitle)
                        .frame(width: UIScreen.main.bounds.width * 64 / 430 )
                    
                    VStack (alignment: .leading){
                        Text("Report")
                            .bold()
                        
                        Text("Check your weekly and monthly reports to see the details of your hair growth.")
                            .opacity(0.7)
                    }
                }
                .padding(.vertical, 14)
                
                Spacer()
                
                NavigationLink{
                    PreCameraGuideView(showingAddProgressSheet: $showingAddProgressSheet, selectedDay: $selectedDay, navigateToSecondOnBoarding: $navigateToSecondOnBoarding)
                } label: {
                    Text("Start Tracking Hair Growth")
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
                    
                    navigateToSecondOnBoarding = true
                    
                } label: {
                    Text("Skip")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundStyle(Color("PrimaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                .navigationDestination(isPresented: $navigateToSecondOnBoarding, destination: {
                    OnBoardingSecondPageView(isOnBoardingComplete: $isOnBoardingComplete, selectedDay: $selectedDay)
                })
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width)
            .background(
                LinearGradient(colors: [Color("SecondaryColor"), .white], startPoint: .bottom, endPoint: .top)
            )
        }
    }
}

#Preview {
    OnBoardingFirstPageView(isOnBoardingComplete: .constant(false), showingAddProgressSheet: .constant(false), selectedDay: .constant(1))
}

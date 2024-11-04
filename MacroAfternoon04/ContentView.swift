//
//  ContentView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 06/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State var selectedTab: Int = 0
    
//    @State var healthManager = HealthManager()
    
    @State var isOnBoardingComplete: Bool = UserDefaults.standard.bool(forKey: "isOnBoardingComplete")
    
    @State var showingAddProgressSheet = false
    
    @State var currentScalpPosition: Int = 1
      
    @State var selectedDay: Int = UserDefaults.standard.integer(forKey: "selectedDay")
    
    var body: some View {
        if !isOnBoardingComplete {
            OnBoardingFirstPageView(isOnBoardingComplete: $isOnBoardingComplete, showingAddProgressSheet: $showingAddProgressSheet, selectedDay: $selectedDay)
                .onDisappear {
                    UserDefaults.standard.set(isOnBoardingComplete, forKey: "isOnboardingComplete")
                }
        } else {
            TabView(selection: $selectedTab) {
                Tab("Home", systemImage: "square.grid.2x2.fill", value: 0) {
                    DashboardView(showingAddProgressSheet: $showingAddProgressSheet, selectedTab: $selectedTab, currentScalpPosition: $currentScalpPosition, selectedDay: $selectedDay)
                }
                
                Tab("History", systemImage: "hourglass", value: 1) {
                    HistoryCircleView(modelContext: modelContext)
                }
            }
//            .task {
//                await healthManager.requestAuthorization()
//            }
        }
    }
}

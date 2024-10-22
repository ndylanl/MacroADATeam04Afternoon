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

    @State var healthManager = HealthManager()
    
    @State var userName: String = ""
    
    @State var isOnboardingComplete: Bool = false
    
    @State var showingAddProgressSheet = false
    
    var body: some View {
        if isOnboardingComplete{
            TabView(selection: $selectedTab) {
                Tab("Home", systemImage: "square.grid.2x2.fill", value: 0) {
                    DashboardView(userName: $userName, showingAddProgressSheet: $showingAddProgressSheet, selectedTab: $selectedTab)
                }
                
                Tab("History", systemImage: "hourglass", value: 1) {
                    HistoryView()
                }
            }.task {
                await healthManager.requestAuthorization()
            }
        } else {
            OnBoardingFirstPageView(userName: $userName, isOnboardingComplete: $isOnboardingComplete, showingAddProgressSheet: $showingAddProgressSheet)
        }
    }
}

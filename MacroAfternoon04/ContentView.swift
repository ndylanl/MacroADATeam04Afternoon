//
//  ContentView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 06/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab: Int = 0
    
    @State private var healthManager = HealthManager()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "square.grid.2x2.fill", value: 0) {
                DashboardView(selectedTab: $selectedTab)
            }
            
            Tab("History", systemImage: "hourglass", value: 1) {
                HistoryView()
            }
        }.task {
            await healthManager.requestAuthorization()
        }
    }
}

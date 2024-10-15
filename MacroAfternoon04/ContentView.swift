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
    
    @State private var healthManager = HealthManager()
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "square.grid.2x2.fill") {
                DashboardView()
            }
            
            Tab("History", systemImage: "hourglass") {
                HistoryView()
            }
        }.task {
            await healthManager.requestAuthorization()
        }
    }
}

#Preview {
    ContentView()
}

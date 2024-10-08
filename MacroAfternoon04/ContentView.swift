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
    @Query private var items: [Item]
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                DashboardView()
            }
            
            Tab("History", systemImage: "hourglass") {
                HistoryView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

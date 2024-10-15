//
//  MacroAfternoon04App.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 06/10/24.
//

import SwiftUI
import SwiftData

@main
struct MacroAfternoon04App: App {
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: ReminderModel.self)
        } catch {
            fatalError("Could not initialize model container: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView().modelContainer(for: ReminderModel.self)
        }
    }
}

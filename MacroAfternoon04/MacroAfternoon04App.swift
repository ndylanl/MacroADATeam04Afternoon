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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var healthViewModel = HealthViewModel()
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: ReminderModel.self, TrackProgressModel.self)
        } catch {
            fatalError("Could not initialize model container: \(error)")
        }
        
        ReminderService.shared.modelContext = modelContainer.mainContext
    }
    
    var body: some Scene {
        WindowGroup {
            //HeatmapView()
            ContentView()
                .modelContainer(for: [TrackProgressModel.self, ReminderModel.self])
                .environmentObject(healthViewModel)
                .onAppear {
                    setupNotificationActions()
                    //ReminderService.shared.resetWeeklyPointsIfNeeded()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification)) { _ in
                    UNUserNotificationCenter.current().delegate = appDelegate
                }
        }
    }
}

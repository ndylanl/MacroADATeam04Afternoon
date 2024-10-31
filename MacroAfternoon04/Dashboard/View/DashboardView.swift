//
//  DashboardView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 08/10/24.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) var modelContext
    
    @Binding var userName: String
    
    @Binding var showingAddProgressSheet: Bool
    
    @Binding var selectedTab: Int
    
    @State var currentScalpArea: Int
    
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
//                    HStack{
//                        VStack(alignment: .leading){
//                            Text("Good Morning,").font(.largeTitle)
//                            Text(userName).font(.largeTitle).bold().textCase(.uppercase)
//                        }
//                        
//                        Spacer()
//                    }
//                    .padding(.horizontal, 28)
                    
                    HairGrowthProgressCardView(showingAddProgressSheet: $showingAddProgressSheet)
                    
                    NavigationLink(destination: ReminderListView(), label: {
                        ReminderCardView()
                    })
                    
                    YourActivityCardView()
                }
                .sheet(isPresented: $showingAddProgressSheet){
                    AddProgressCameraSheetView(currentScalpPosition: $currentScalpArea)
                }
            }
            .background(
                Image("placeholderDashboardBackground")
                    .resizable()
            )
            
            .navigationTitle("Dashboard")
            
            .toolbar{
                
                ToolbarItem(placement: .topBarTrailing){
                    HStack {
                        Button(action: {
                            isShowAlert = true
                        }) {
                            Image(systemName: "gear")
                        }
                        
                        // Button untuk membuka HealthView
                        //                        NavigationLink(destination: HealthView()) {
                        //                            Image(systemName: "heart")
                        //                        }
                    }
                }
            }
            .alert("Title", isPresented: $isShowAlert) {
                
                Button("Delete", role: .destructive) {
                    resetAllData(modelContext: modelContext)
                }
            } message: {
                Text("Message")
            }
            
        }
    }
    
    func resetAllData(modelContext: ModelContext) {
        let fetchRequestReminder = FetchDescriptor<ReminderModel>()
        let fetchRequestTrackProgress = FetchDescriptor<TrackProgressModel>()
        
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "isOnBoardingComplete")
        
        UserDefaults.standard.set("", forKey: "userName")
        UserDefaults.standard.set(false, forKey: "isOnBoardingComplete")
        
        print(UserDefaults.standard.bool(forKey: "isOnBoardingComplete"))
        
        do {
            let reminders = try modelContext.fetch(fetchRequestReminder)
            let trackProgresses = try modelContext.fetch(fetchRequestTrackProgress)
            
            for reminder in reminders {
                modelContext.delete(reminder)
            }
            
            for trackProgress in trackProgresses {
                modelContext.delete(trackProgress)
            }
            
            try modelContext.save()
        } catch {
            print("Failed to reset data: \(error)")
        }
    }
}

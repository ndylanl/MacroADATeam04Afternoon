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
    
    @Binding var showingAddProgressSheet: Bool
    
    @Binding var selectedTab: Int
    
    @Binding var currentScalpPosition: Int
    
    @Binding var selectedDay: Int
    
    @State var showingSettingsSheet: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    
                    HairGrowthProgressCardView(showingAddProgressSheet: $showingAddProgressSheet, selectedDay: $selectedDay)
                    
                    NavigationLink(destination: ReminderListView(), label: {
                        ReminderCardView()
                    })
                    
                    YourActivityCardView()
                }
                .sheet(isPresented: $showingAddProgressSheet){
                    AddProgressCameraSheetView(currentScalpPosition: $currentScalpPosition)
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
                            showingSettingsSheet = true
                        }) {
                            Image(systemName: "gear")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingSettingsSheet, content: {
                SettingsSheetView(selectedDay: $selectedDay)
            })
        }
    }
}

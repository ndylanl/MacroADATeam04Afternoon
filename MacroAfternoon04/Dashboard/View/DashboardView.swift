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
    
//    @Binding var userName: String
    
    @Binding var showingAddProgressSheet: Bool
    
    @Binding var showingSleepAndMovementSheet: Bool
    
    @Binding var selectedTab: Int
    
    @Binding var currentScalpPosition: Int
    
    @Binding var selectedDay: Int
    
    @State var showingSettingsSheet: Bool = false
    
    
    var body: some View {
        NavigationStack{

            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [Color("DashboardGray"), Color("SecondaryColor")]),
                    startPoint: UnitPoint(x: 0.5, y: 0.25),  
                    endPoint: UnitPoint(x: 0.5, y: 0.75)
                ).ignoresSafeArea()
                
                ScrollView{
                    VStack{
                        Spacer()
                        
                        HairGrowthProgressCardView(showingAddProgressSheet: $showingAddProgressSheet, selectedDay: $selectedDay, modelContext: modelContext)
                        
                        Spacer()
                        
                        NavigationLink(destination: ReminderListView(), label: {
                            ReminderCardView()
                        })
                        .padding(10)
                        
                        
                        YourActivityCardView(isInfoSheetPresented: $showingSleepAndMovementSheet)
                        
                        
                        DailyTipsView()
                            .padding(10)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .edgesIgnoringSafeArea(.all)
                }
                .frame(width: UIScreen.main.bounds.width)
            }

            
            .navigationTitle("Dashboard")
            .toolbarBackground(.clear, for: .navigationBar)
            
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
            .sheet(isPresented: $showingSleepAndMovementSheet, content: {
                InfoSleepAndMovementSheetView(isPresented: $showingSleepAndMovementSheet)
            })
        }
    }
}

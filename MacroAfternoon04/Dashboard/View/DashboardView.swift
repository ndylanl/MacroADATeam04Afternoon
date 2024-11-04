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
    
    @Binding var selectedTab: Int
    
    @Binding var currentScalpPosition: Int
    
    @Binding var selectedDay: Int
    
    @State var showingSettingsSheet: Bool = false
    
    var body: some View {
        NavigationStack{
            //            ScrollView{
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [Color("DashboardGray"), Color("SecondaryColor")]),
                    startPoint: UnitPoint(x: 0.5, y: 0.25),  // Near top-center
                    endPoint: UnitPoint(x: 0.5, y: 0.75)
                ).ignoresSafeArea()
                
                ScrollView{
                    VStack{
                        Spacer()
                        
                        HairGrowthProgressCardView(showingAddProgressSheet: $showingAddProgressSheet, selectedDay: $selectedDay)
                        
                        Spacer()
                        
                        NavigationLink(destination: ReminderListView(), label: {
                            ReminderCardView()
                        })
                        .padding(10)
                        
                        HStack {
                            Spacer()
                            YourActivityCardView()
                            Spacer()
                        }
                        Spacer()
                        
                        
                        DailyTipsView()
                            .padding(10)
                    }
                    .sheet(isPresented: $showingAddProgressSheet){
                        AddProgressCameraSheetView()
                        
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            
            
            
            //            }
            //            .ignoresSafeArea()
            //            .scrollContentBackground(.hidden)
            //            .background(
            //                Image("placeholderDashboardBackground")
            //                    .resizable()
            //            )
            
            .navigationTitle("Dashboard")
            .toolbarBackground(.clear, for: .navigationBar)
            //            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            //            .navigationBarTitleTextColor(.blue)
            
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
//
//#Preview {
//    DashboardView(userName: .constant("Anin"), showingAddProgressSheet: .constant(false), selectedTab: .constant(0))
//}

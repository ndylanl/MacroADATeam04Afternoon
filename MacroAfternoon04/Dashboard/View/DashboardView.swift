//
//  DashboardView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 08/10/24.
//

import SwiftUI

struct DashboardView: View {
    @Binding var userName: String
    
    @Binding var showingAddProgressSheet: Bool
    
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Good Morning,").font(.largeTitle)
                            Text(userName).font(.largeTitle).bold().textCase(.uppercase)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 28)
                    
                    NavigationLink(destination: ReminderListView(), label: {
                        ReminderCardView()
                    })
                    
                    HairGrowthProgressCardView(showingAddProgressSheet: $showingAddProgressSheet)
                    
                    YourActivityCardView()
                }
                .sheet(isPresented: $showingAddProgressSheet){
                    AddProgressCameraSheetView()
                }
            }
            .background(
                Image("placeholderDashboardBackground")
                    .resizable()
            )
            
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar{
                
                ToolbarItem(placement: .topBarTrailing){
                    HStack {
                        Button(action: {
                            print("Settings button pressed")
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
            .toolbarTitleMenu(content: {
                
            }
            )}
    }
}

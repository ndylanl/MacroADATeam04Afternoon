//
//  DashboardView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 08/10/24.
//

import SwiftUI

struct DashboardView: View {
    @State var showingAddProgressSheet = false
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Good Morning,").font(.largeTitle)
                            Text("DORY").font(.largeTitle).bold()
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 28)
                    
                    
                    //                    Button{
                    //                        selectedTab = 1
                    //                    } label: {
                    //                        ReminderCardView()
                    //                    }
                    
                    NavigationLink(destination: ReminderListView(), label: {
                        ReminderCardView()
                    })
                    
                    //                    HStack{
                    //                        Button {
                    //                            showingAddProgressSheet.toggle()
                    //                        } label: {
                    //                            AddProgressCardView()
                    //                        }
                    //                        .sheet(isPresented: $showingAddProgressSheet){
                    //                            AddProgressCameraSheetView()
                    //                        }
                    //
                    //                        NavigationLink {
                    //                            PlaceholderView()
                    //                        } label: {
                    //                            LastProgressCardView()
                    //                        }
                    //                    }
                    //                    .padding()
                    
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
                    Button(action: {
                        print("Settings button pressed")
                    }){
                        Image(systemName: "gear")
                    }
                }
            }
            .toolbarTitleMenu(content: {
                
            }
            )}
    }
}

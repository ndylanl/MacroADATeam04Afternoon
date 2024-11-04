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
    
    @State var isShowAlert: Bool = false
    
    
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

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.backgroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.backgroundColor: uiColor ]
        return self
    }
}

#Preview {
    DashboardView(userName: .constant("Anin"), showingAddProgressSheet: .constant(false), selectedTab: .constant(0))
}

//
//  Hair Growth Progress.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 15/10/24.
//

import SwiftUI
import SwiftData

struct HairGrowthProgressCardView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Binding var showingAddProgressSheet: Bool
    @Binding var selectedDay: Int
    @State var showingPreCameraGuideView: Bool = false
    
    @StateObject var viewModel: RecentProgressViewModel
    
    @State private var isButtonEnabled: Bool = false
    @State private var daysLeft: Int = 7
    
    @State var selectedOption = UserDefaults.standard.string(forKey: "ScalpAreaChosen") ?? ""
    
    
    init(showingAddProgressSheet: Binding<Bool>, selectedDay: Binding<Int>, modelContext: ModelContext) {
        self._showingAddProgressSheet = showingAddProgressSheet
        self._selectedDay = selectedDay
        self._viewModel = StateObject(wrappedValue: RecentProgressViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        ZStack(){
            RoundedCornerComponentView()
            
            VStack(alignment: .leading){
                
                Text("✦ Hair Growth Progress")
                    .font(.title3)
                
                HStack{
                    
                    if isButtonEnabled {
                        
                        Button {
                            if selectedOption == "" {
                                showingPreCameraGuideView = true
                            } else {
                                showingAddProgressSheet = true
                            }
                        } label: {
                            AddProgressCardView()
                        }
                        
                    } else {
                        DisabledAddProgressView(daysLeft: $daysLeft)
                    }
                    
                    Spacer()
                    
                    NavigationLink{
                        WeekReportView(date: viewModel.lastDate, viewModel: WeeklyReportViewModel(modelContext: modelContext, weekDate: viewModel.lastDate))
                    } label: {
                        LastProgressCardView()
                    }
                    .disabled(selectedOption == "")
                    
                }
                .shadow(radius: 4, x: 0, y: 2)
            }
            .frame(width: cardWidthSize() - 32)
        }
        .frame(width: cardWidthSize(), height: cardHeightSize())
        .onAppear {
            checkButtonAvailability()
        }
        .onChange(of: showingAddProgressSheet) { oldValue, newValue in
            checkButtonAvailability()
            checkRecentAvailability()
        }
        .onChange(of: selectedDay) { oldValue, newValue in
            checkButtonAvailability()
        }
        .sheet(isPresented: $showingAddProgressSheet) {
            AddProgressCameraSheetView(showingAddProgressSheet: $showingAddProgressSheet, selectedDay: $selectedDay)
        }
        .sheet(isPresented: $showingPreCameraGuideView) {
            PreCameraGuideView(showingAddProgressSheet: $showingAddProgressSheet, isOnBoardingComplete: .constant(true), selectedDay: $selectedDay, navigateToSecondOnBoarding: .constant(false))
            
        }
    }
    
    func checkButtonAvailability() {
        
        if isTrackProgressModelEmpty() {
            isButtonEnabled = true
            daysLeft = 0
        } else {
            let today = Calendar.current.startOfDay(for: Date())
            let dayBefore = Calendar.current.date(byAdding: .day, value: -1, to: today)!
            let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            
            let selectedDayDate = Calendar.current.date(bySetting: .weekday, value: selectedDay, of: today)!
            
            if selectedDayDate == today || selectedDayDate == dayBefore || selectedDayDate == dayAfter {
                
                isButtonEnabled = !isDateInTrackProgressModel(today: today, dayBefore: dayBefore, dayAfter: dayAfter)
                
            } else {
                isButtonEnabled = false
                daysLeft = Calendar.current.dateComponents([.day], from: today, to: selectedDayDate).day ?? 6
            }
        }
    }
    
    func checkRecentAvailability() {
        selectedOption = UserDefaults.standard.string(forKey: "ScalpAreaChosen") ?? ""
    }
    
    
    func isTrackProgressModelEmpty() -> Bool {
        let fetchDescriptor = FetchDescriptor<TrackProgressModel>()
        
        do {
            let results = try modelContext.fetch(fetchDescriptor)
            return results.isEmpty
        } catch {
            print("Failed to fetch TrackProgressModel: \(error)")
            return false
        }
    }
    
    func isDateInTrackProgressModel(today: Date, dayBefore: Date, dayAfter: Date) -> Bool {
        let predicate = #Predicate<TrackProgressModel> {
            $0.dateTaken >= dayBefore && $0.dateTaken <= dayAfter
        }
        
        let fetchDescriptor = FetchDescriptor<TrackProgressModel>(predicate: predicate)
        
        do {
            let results = try modelContext.fetch(fetchDescriptor)
            return !results.isEmpty
        } catch {
            print("Failed to fetch TrackProgressModel: \(error)")
            return false
        }
    }
}

func cardWidthSize() -> CGFloat{
    (UIScreen.main.bounds.width * 374 / 430)
}

func cardHeightSize() ->CGFloat{
    (UIScreen.main.bounds.height * 193 / 985)
}

//
//  Hair Growth Progress.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 15/10/24.
//

import SwiftUI
import SwiftData

struct HairGrowthProgressCardView: View {
    
    @Binding var showingAddProgressSheet: Bool
    @Binding var selectedDay: Int
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var isButtonEnabled: Bool = false
    
    var body: some View {
        ZStack(){
            RoundedCornerComponentView()
//            Image("placeholderDashboardYourActivityCard")
//                .resizable()
//                .clipShape(RoundedRectangle(cornerRadius: 18))
            
            VStack(alignment: .leading){
                
                Text("✦ Hair Growth Progress")
                    .font(.title3)
                
//                Divider()
                
                HStack{
                    
                    if isButtonEnabled {
                        NavigationLink {
                            PreCameraGuideView(showingAddProgressSheet: $showingAddProgressSheet)
                        } label: {
                            AddProgressCardView()
                        }
                    } else {
                        AddProgressCardView()
                            .opacity(0.5)
                    }
                    
                    Spacer()
                    
                    NavigationLink{
                        RecentProgressView(viewModel: RecentProgressViewModel(modelContext: modelContext))
                    } label: {
                        LastProgressCardView()
                    }
                    
                }
                .shadow(radius: 4, x: 0, y: 2)
            }
            .frame(width: cardWidthSize() - 32)
        }
        .frame(width: cardWidthSize(), height: cardHeightSize())
        .onAppear {
            checkButtonAvailability()
        }
    }
    
    func checkButtonAvailability() {
        
        if isTrackProgressModelEmpty() {
            isButtonEnabled = true
            
        }else {
            let today = Calendar.current.startOfDay(for: Date())
            let dayBefore = Calendar.current.date(byAdding: .day, value: -1, to: today)!
            let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            
            let selectedDayDate = Calendar.current.date(bySetting: .weekday, value: selectedDay, of: today)!
            
            if selectedDayDate == today || selectedDayDate == dayBefore || selectedDayDate == dayAfter {
                
                isButtonEnabled = !isDateInTrackProgressModel(today: today, dayBefore: dayBefore, dayAfter: dayAfter)
                
            } else {
                isButtonEnabled = false
            }
        }
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

#Preview {
    HairGrowthProgressCardView(showingAddProgressSheet: .constant(false))
}

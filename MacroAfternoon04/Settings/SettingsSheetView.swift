//
//  SettingsSheetView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 01/11/24.
//

import SwiftUI

struct SettingsSheetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedDay: Int
    @State var selectedPickerDay: Int = UserDefaults.standard.integer(forKey: "selectedDay")
    
    @State var isShowAlert: Bool = false
    
    @State private var HealthAccess: Bool = false
    
    @State private var selectedOption = UserDefaults.standard.string(forKey: "ScalpAreaChosen") ?? "A. All Scalp"
    
    let options = ["A. All Scalp", "B. Left Side", "C. Right Side", "D. Front Side", "E. Middle Side", "F. Back Side"]
    
    @State var selectedHour: Int = UserDefaults.standard.integer(forKey: "selectedHour")
    @State var selectedMinute: Int = UserDefaults.standard.integer(forKey: "selectedMinute")
    let hours = Array(0...23)
    let minutes = Array(0...59)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
  
                    Spacer()
                    
                    VStack{
                        HStack{
                            Text("Select Scalp Area")
                                .bold()
                                .font(.title2)
                                .padding()
                                .padding(.horizontal, 12)

                            
                            Spacer()
                        }
                        
                        VStack(spacing: 0){
                            HStack(spacing: 0){
                                ZStack(alignment: .topLeading) {
                                    // Square background
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/3.5)
                                        .border(Color.gray, width: 1)
                                    
                                    // Top-left text
                                    Text("A")
                                        .font(.body)
                                        .padding(7)
                                    
                                    // Centered image
                                    Image("ScalpFull") // Replace with the name of your image asset
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/4)
                                        .padding(.top, 8)
                                    
                                }
                                
                                ZStack(alignment: .topLeading) {
                                    // Square background
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/3.5)
                                        .border(Color.gray, width: 1)
                                    
                                    // Top-left text
                                    Text("B")
                                        .font(.body)
                                        .padding(7)
                                    
                                    // Centered image
                                    Image("ScalpLeft") // Replace with the name of your image asset
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/4)
                                        .padding(.top, 8)
                                    
                                }
                                
                                ZStack(alignment: .topLeading) {
                                    // Square background
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/3.5)
                                        .border(Color.gray, width: 1)
                                    
                                    // Top-left text
                                    Text("C")
                                        .font(.body)
                                        .padding(7)
                                    
                                    // Centered image
                                    Image("ScalpRight") // Replace with the name of your image asset
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/4)
                                        .padding(.top, 8)
                                    
                                }
                            }
                            
                            HStack(spacing: 0){
                                ZStack(alignment: .topLeading) {
                                    // Square background
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/3.5)
                                        .border(Color.gray, width: 1)
                                    
                                    // Top-left text
                                    Text("D")
                                        .font(.body)
                                        .padding(7)
                                    
                                    // Centered image
                                    Image("ScalpTop") // Replace with the name of your image asset
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/4)
                                        .padding(.top, 8)
                                    
                                }
                                
                                ZStack(alignment: .topLeading) {
                                    // Square background
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/3.5)
                                        .border(Color.gray, width: 1)
                                    
                                    // Top-left text
                                    Text("E")
                                        .font(.body)
                                        .padding(7)
                                    
                                    // Centered image
                                    Image("ScalpMid") // Replace with the name of your image asset
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/4)
                                        .padding(.top, 8)
                                    
                                }
                                
                                ZStack(alignment: .topLeading) {
                                    // Square background
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/3.5)
                                        .border(Color.gray, width: 1)
                                    
                                    // Top-left text
                                    Text("F")
                                        .font(.body)
                                        .padding(7)
                                    
                                    // Centered image
                                    Image("ScalpBottom") // Replace with the name of your image asset
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: frameWidth()/3.5, height: frameWidth()/4)
                                        .padding(.top, 8)
                                    
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        Picker("Select an Option", selection: $selectedOption) {
                            // Loop through options to create picker items
                            ForEach(options, id: \.self) { option in
                                Text(option)
                                    .foregroundStyle(Color("PrimaryColor"))
                                
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                        .padding(.horizontal)
                        .padding(.horizontal, 12)
                        .frame(maxWidth: frameWidth()) // Make it expand horizontally
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("PrimaryColor"), lineWidth: 1) // Add blue border
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white) // White background
                                        .shadow(radius: 2, x: 5, y: 5)
                                    
                                )
                        )
                        .padding(.horizontal, 12)
                        .padding()
                        
                        Text("By choosing a more specific scalp area based on your current condition, you will be able to track more accurately.")
                            .font(.footnote)
                            .foregroundColor(Color("NeutralColor")) // Set the color here
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(width: frameWidth())
                    .padding(.bottom, 40)
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text("Select Photo Taking Day")
                            .font(.title2).bold()
                        
                        Text("When selecting a day to take a hair photo, users can upload photos for that day, the day before, and the day after.")
                            .font(.footnote)
                            .padding(.top, 2)
                            .foregroundStyle(Color("NeutralColor"))
                    }
                    .padding(.horizontal)
                    .padding(.top, -4)
                    .padding(.horizontal, 12)
                    .frame(width: frameWidth())
                    
                    
                    Section{
                        HStack{
                            Picker("Select Day", selection: $selectedPickerDay) {
                                ForEach(1..<8) { day in
                                    Text(self.dayName(for: day)).tag(day)
                                }
                            }
                            .pickerStyle(.inline)
                            
                            Picker("Hour", selection: $selectedHour) {
                                ForEach(0..<hours.count) { index in
                                    Text("\(self.hours[index])").tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                            Picker("Minute", selection: $selectedMinute) {
                                ForEach(0..<minutes.count) { index in
                                    Text("\(self.minutes[index])").tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(width: frameWidth() * 374 / 430)
                    .padding()
                }
                .background(Color(.systemGray6))
                .padding()
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                            //-- selectedScalp
                            UserDefaults.standard.set(selectedOption, forKey: "ScalpAreaChosen")
                            
                            
                            //---- selectedDay
                            selectedDay = selectedPickerDay
                            UserDefaults.standard.set(self.selectedDay, forKey: "selectedDay")
                            //---- notification
                            UserDefaults.standard.set(self.selectedHour, forKey: "selectedHour")
                            UserDefaults.standard.set(self.selectedMinute, forKey: "selectedMinute")
                            addProgressNotification(selectedDay: selectedDay, selectedHour: selectedHour, selectedMinute: selectedMinute)
                            
                            //----
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Text("Done")
                        }
                    }
                }
                .ignoresSafeArea(.all)
                .background(Color(.systemGray6))
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.white, Color(.systemGray6), Color(.systemGray6)]), startPoint: .top, endPoint: .bottom)
            )
            
        }
    }
    
    private func dayName(for day: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let date = Calendar.current.date(bySetting: .weekday, value: day, of: Date())!
        return formatter.string(from: date)
    }
    
    func frameWidth() -> CGFloat {
        UIScreen.main.bounds.width
    }
    
    func frameHeight() -> CGFloat {
        UIScreen.main.bounds.height
    }
}

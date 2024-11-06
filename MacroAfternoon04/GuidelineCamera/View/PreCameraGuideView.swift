//
//  PreCameraGuideView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 30/10/24.
//

import SwiftUI


struct PreCameraGuideView: View {
    //@Binding var showingAddProgressSheet: Bool
    
    @State private var selectedOption = "A. All Scalp"
    let options = ["A. All Scalp", "B. Left Side", "C. Right Side", "D. Front Side", "E. Middle Side", "F. Back Side"]
    
    @Binding var showingAddProgressSheet: Bool
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State var isOnBoardingComplete: Bool = UserDefaults.standard.bool(forKey: "isOnBoardingComplete")
    
    @Binding var selectedDay: Int
    
    @Binding var navigateToSecondOnBoarding: Bool
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Macro Photos Will Be Taken With Assistance")
                    .font(.largeTitle)
                    .padding()
                Text("Make sure you have a good lighting and another person to help take photos of your scalp.")
                    .font(.body)
                    .padding(.horizontal)
                Text("Select Scalp Area")
                    .bold()
                    .font(.title2)
                    .padding()
                
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
                .padding(.vertical)
                .padding(.leading)
                .padding(.trailing, 0)
                
                
                Text("By choosing a more specific scalp area based on your current condition, you will be able to track more accurately.")
                    .font(.footnote)
                    .foregroundColor(.gray) // Set the color here
                    .padding(.top)
                    .padding(.leading)
                
                Button{
                    selectedOption = "A. All Scalp"
                    // actions here
                    UserDefaults.standard.set(selectedOption, forKey: "ScalpAreaChosen")
                    // this is how to grab it
                    let exampleFetchScalpAreaChosen = UserDefaults.standard.string(forKey: "ScalpAreaChosen")
                    print(exampleFetchScalpAreaChosen!)
                    showingAddProgressSheet.toggle()
                    
                } label: {
                    Text("Take Photos Now")
                }
                .foregroundStyle(.white)
                .frame(width: frameWidth() - 56, height: 48)
                .background(Color("PrimaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .padding(.top)
                
                NavigationLink{
                    // ISI INI NAVIGATE KE HEALTH ONBOARDING
                    OnBoardingSecondPageView(isOnBoardingComplete: $isOnBoardingComplete, selectedDay: $selectedDay)
                    
                } label: {
                    Text("Skip")
                        .foregroundStyle(Color("PrimaryColor"))
                }
                .frame(width: frameWidth() - 56, height: 48)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
                .sheet(isPresented: $showingAddProgressSheet, onDismiss: {
                    if !isOnBoardingComplete {
                        
                        let currentDay = Calendar.current.component(.weekday, from: Date())
                        selectedDay = currentDay
                        UserDefaults.standard.set(selectedDay, forKey: "selectedDay")
                        
                        navigateToSecondOnBoarding = true
                        
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                }){
                    AddProgressCameraSheetView(showingAddProgressSheet: $showingAddProgressSheet)
                }
                
                
            }
            //        .frame(height: frameHeight())
            .ignoresSafeArea(.all)
            .padding(.horizontal, 20)
            .background(
                LinearGradient(gradient: Gradient(colors: [.white, Color("SecondaryColor")]), startPoint: .top, endPoint: .bottom)
            )
        }
        
        .navigationBarBackButtonHidden(true) // Hides the back button
    }
    
    
    func frameWidth() -> CGFloat {
        UIScreen.main.bounds.width
    }
    
    func frameHeight() -> CGFloat {
        UIScreen.main.bounds.height
    }
}
//
//
//#Preview {
//    @State var temp: Bool = false
//    PreCameraGuideView(showingAddProgressSheet: $temp)
//}

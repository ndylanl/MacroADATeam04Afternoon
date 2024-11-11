//
//  OnBoardingThirdPage.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 05/11/24.
//

import SwiftUI

struct OnBoardingThirdPageView: View {
    
    @Binding var isOnBoardingComplete: Bool
    
    var body: some View {
        VStack(alignment: .center){
            Text("Congratulations")
                .font(.title)
            
            Text("You have completed your first hair progress tracking")
                .font(.title2)
                .multilineTextAlignment(.center)
            
            HStack{
                Image("OnBoardingThird")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 378 / 430, height: UIScreen.main.bounds.width * 296 / 430)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 100)
            
            Spacer()
            
            Text("You can check your results in Recent Report on Dashboard")
                .font(.footnote)
                .opacity(0.5)
            
            Button{
                
                isOnBoardingComplete = true
                UserDefaults.standard.set(isOnBoardingComplete, forKey: "isOnBoardingComplete")
                
                UserDefaults.standard.set(8, forKey: "selectedHour")
                UserDefaults.standard.set(0, forKey: "selectedMinute")

                
            } label: {
                Text("Go to Dashboard")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .foregroundStyle(Color("SecondaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button{
                // empty
            } label: {
                Text("Skip")
                    .opacity(0.0)
            }
            .disabled(true)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(Color("PrimaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        .background(
            LinearGradient(colors: [Color("SecondaryColor"), .white], startPoint: .bottom, endPoint: .top)
        )
        .navigationBarHidden(true)
    }
}

//#Preview {
//    OnBoardingThirdPageView(isOnBoardingComplete: .constant(false), selectedDay: .constant(1))
//}

//
//  OnBoardingViewSecondPage.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 22/10/24.
//

import SwiftUI

struct OnBoardingSecondPageView: View {
    @Binding var isOnBoardingComplete: Bool
    @Binding var showingAddProgressSheet: Bool
    @Binding var userName: String
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("Photos Will Be Taken Automatically")
                        .font(.largeTitle)
                    
                    Text("Make sure you have a good lighting so your position can be detected clearly. ")
                        .font(.body)
                        .padding(.top)
                    
                }
                .padding(.top, 94)
                
                Spacer()
                
            }
            .frame(width: frameWidth() - 56, height: frameHeight() * 3 / 4, alignment: .top)
            
            Button{
                showingAddProgressSheet = true
                isOnBoardingComplete = true
                UserDefaults.standard.set(isOnBoardingComplete, forKey: "isOnBoardingComplete")
                UserDefaults.standard.set(userName, forKey: "userName")
            } label: {
                Text("Start Tracking Hair Growth")
            }
            .foregroundStyle(.white)
            .frame(width: frameWidth() - 56, height: 48)
            .background(Color("PrimaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button{
                isOnBoardingComplete = true
                UserDefaults.standard.set(isOnBoardingComplete, forKey: "isOnBoardingComplete")
                UserDefaults.standard.set(userName, forKey: "userName")
            } label: {
                Text("Skip")
            }
            .foregroundStyle(Color("PrimaryColor"))
            .frame(height: 48)
            //            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(width: frameWidth(), height: frameHeight(), alignment: .top)
        .background(
            LinearGradient(gradient: Gradient(colors: [.white, Color("SecondaryColor")]), startPoint: .top, endPoint: .bottom)
        )
        .toolbar(.hidden)
    }
    
    
    func frameWidth() -> CGFloat {
        UIScreen.main.bounds.width
    }
    
    func frameHeight() -> CGFloat {
        UIScreen.main.bounds.height
    }
}




//
//  OnBoardingFirstPageView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 22/10/24.
//

import SwiftUI

struct OnBoardingFirstPageView: View {
    @Binding var userName: String
    @Binding var isOnboardingComplete: Bool
    @Binding var showingAddProgressSheet: Bool
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Track Your Hair Growth")
                            .font(.largeTitle)
                        
                        Text("Consistently")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Take photos of your hair treatment progress regularly to see changes and be motivated")
                        
                            .font(.body)
                            .padding(.top)
                    }
                    .padding(.top, 94)
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text("What is your name?")
                            .font(.title2)
                        TextField("Enter your name", text: $userName)
                            .padding()
                            .frame(height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .frame(height: UIScreen.main.bounds.height / 3, alignment: .bottom)
                    .padding(.bottom)
                }
                .frame(width: frameWidth() - 56, height: frameHeight() * 3 / 4, alignment: .top)
                
                NavigationLink{
                    OnBoardingSecondPageView(isOnBoardingComplete: $isOnboardingComplete, showingAddProgressSheet: $showingAddProgressSheet, userName: $userName)
                } label: {
                    Text("Start Tracking Hair Growth")
                }
                .foregroundStyle(.white)
                .frame(width: frameWidth() - 56, height: 48)
                .background(Color("PrimaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .frame(width: frameWidth(), height: frameHeight(), alignment: .top)
            .background(
                LinearGradient(gradient: Gradient(colors: [.white, Color("SecondaryColor")]), startPoint: .top, endPoint: .bottom)
            )
        }
    }
    
    
    func frameWidth() -> CGFloat {
        UIScreen.main.bounds.width
    }
    
    func frameHeight() -> CGFloat {
        UIScreen.main.bounds.height
    }
}

//#Preview {
//    @Previewable @State var userName = ""
//    @Previewable @State var isOnboardingComplete = false
//    @Previewable @State var showingAddProgressSheet = false
//
//    return OnBoardingFirstPageView(userName: $userName, isOnboardingComplete: $isOnboardingComplete, showingAddProgressSheet: $showingAddProgressSheet)
//}

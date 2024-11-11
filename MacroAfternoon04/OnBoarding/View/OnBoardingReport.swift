//
//  OnBoardingThirdPage.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 05/11/24.
//

import SwiftUI

struct OnBoardingReportView: View {
    
    @Binding var isOnBoardingHistoryComplete: Bool
    
    var body: some View {
//        NavigationStack{
            VStack(alignment: .leading){
                Text("Track Your Hair Growth")
                    .font(.title)
                
                Text("Consistently")
                    .font(.title).bold()
                
                Text("Be motivated and well-reminded to maintain a good hair treatment journey.")
                    .font(.body)
                    .padding(.vertical)
                
                HStack{
                    Image(systemName: "circle.circle")
                        .font(.largeTitle)
                        .frame(width: UIScreen.main.bounds.width * 64 / 430 )
                    
                    VStack (alignment: .leading){
                        Text("Heat Map")
                            .bold()
                        
                        Text("See your hair growth progress visualized in a Heat Map with information about your hair’s condition over certain timeline.")
                            .opacity(0.7)
                    }
                }
                .padding(.vertical, 14)
                
                HStack{
                    Image(systemName: "camera.viewfinder")
                        .font(.largeTitle)
                        .frame(width: UIScreen.main.bounds.width * 64 / 430 )
                    
                    VStack (alignment: .leading){
                        Text("Macro Photo")
                            .bold()
                        
                        Text("Get insights with macro photos that reveal number of hairs per follicle.")
                            .opacity(0.7)
                    }
                }
                .padding(.vertical, 14)
                
                
                
                Spacer()
                
                Button{
                    isOnBoardingHistoryComplete = true
                    
                    UserDefaults.standard.set(isOnBoardingHistoryComplete, forKey: "onBoardingReportCompleted")
                } label: {
                    Text("Start Tracking Hair Growth")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("PrimaryColor"))
                .foregroundStyle(Color("SecondaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Button{
                    
                    
                } label: {
                    Text(" ")
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
            .toolbarVisibility(.hidden)
        }
//    }
}

#Preview {
    OnBoardingReportView(isOnBoardingHistoryComplete: .constant(false))
}

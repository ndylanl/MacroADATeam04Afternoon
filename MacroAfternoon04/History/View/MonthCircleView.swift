//
//  MonthCircleView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 28/10/24.
//

import SwiftUI

struct MonthCircleView: View {
    var nameOfTheMonth: String
    
    var body: some View {
        VStack{
            Text(nameOfTheMonth)
                .font(.title2).bold()
                .textCase(.uppercase)
            Text("Report")
                .font(.body)
        }
        .foregroundStyle(Color("PrimaryColor"))
        .frame(width: getCircleSize(), height: getCircleSize())
        .background(
//            LinearGradient(gradient: Gradient(colors: [Color("SecondaryColor"), Color("PrimaryColor")]), startPoint: .top, endPoint: .bottom)
            Color("SecondaryColor")
        )
        .clipShape(Circle())
//        .shadow(color: Color("PrimaryColor").opacity(0.85), radius: 8, x: 0, y: 4)
        .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 2)
        
    }
    
    private func getCircleSize() -> CGFloat {
        UIScreen.main.bounds.width * 255 / 430
    }
}

#Preview {
    MonthCircleView(nameOfTheMonth: "October")
}

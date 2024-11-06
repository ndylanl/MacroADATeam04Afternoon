//
//  RoundedCornerComponentGrayView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 06/11/24.
//

import SwiftUI

struct RoundedCornerComponentGrayView: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .shadow(radius: 4, x: 0, y: 4)
            .opacity(0.5)
        
//        LinearGradient(
//            gradient: Gradient(colors: [Color.white, Color("SecondaryColor")]),
//            startPoint: UnitPoint(x: 0.5, y: 0.01),  // Near top-center
//            endPoint: UnitPoint(x: 0.5, y: 0.09)
//        )
    }
}


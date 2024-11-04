//
//  RoundedCornerComponentBlueView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 30/10/24.
//

import SwiftUI

struct RoundedCornerComponentBlueView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            //.fill(Color("SecondaryColor"))
            .shadow(radius: 4, x: 0, y: 4)
            .opacity(0.5)
        
        LinearGradient(
            gradient: Gradient(colors: [Color.white, Color("SecondaryColor")]),
            startPoint: UnitPoint(x: 0.5, y: 0.01),  // Near top-center
            endPoint: UnitPoint(x: 0.5, y: 0.09)
        )
    }
}

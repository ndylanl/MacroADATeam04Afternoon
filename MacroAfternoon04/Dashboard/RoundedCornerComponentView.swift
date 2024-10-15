//
//  RoundedCornerComponentView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 09/10/24.
//

import SwiftUI

struct RoundedCornerComponentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius:18)
            .fill(Color.white)
            .shadow(radius: 4, x: 0, y: 4)
            .opacity(0.5)
    }
}

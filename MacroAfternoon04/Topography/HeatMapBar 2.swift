//
//  HeatMapBar.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 12/11/24.
//

import SwiftUI

struct HeatMapBar2: View {
    var body: some View {
        HStack(spacing: 0){
            Text("Hair Per Follicle Difference")
                .padding(.top, 200)
                .padding(.leading, 20)
                .font(.system(size: 15))
                .frame(width:240, height: 30)
                .rotationEffect(.degrees(-90))

            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(UIColor(hue: 2*(CGFloat(1)/3), saturation: 0.95, brightness: 0.8, alpha:1)), Color.blue, Color.cyan, Color.green, Color.yellow, Color.red, Color(UIColor(hue: 2*(CGFloat(0)/3), saturation: 0.95, brightness: 0.8, alpha:1))]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .padding(.bottom, 20)
                .frame(width: 30, height: 240)
            }
            
            VStack(alignment: .leading) {
                Text("- 3.0").font(.caption)
                Spacer()
                Text("- 2.0").font(.caption)
                Spacer()
                Text("- 1.0").font(.caption)
                Spacer()
                Text("- 0").font(.caption)
                Spacer()
                Text("- (1.0)").font(.caption)
                Spacer()
                Text("- (2.0)").font(.caption)
                Spacer()
                Text("- (3.0)").font(.caption)
            }
            .frame(width: 40, height: 220)
            .padding(.bottom, 20)
            .foregroundStyle(Color.black)
        }
        .padding(.leading, -220)
        
    }
}

#Preview {
    HeatMapBar2()
}

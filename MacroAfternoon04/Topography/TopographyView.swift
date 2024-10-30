//
//  TopographyView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 28/10/24.
//

import SwiftUI
import UIKit


struct TopographyView: View {
    var points: [Float] = [1,0.5,1,1,0.1,1,1,0.2,1,1,0.6,1]
    
    var body: some View {
        //        VStack{
        //            ForEach(points, id:\.self){ point in
        //                HStack{
        //                    ForEach(point, id:\.self){p in
        //                        let clampedValue = min(max(p, 0), 1) // Clamp the value between 0 and 1
        //
        //                        Rectangle()
        //                            .fill(interpolatedColor(for: clampedValue))
        //                            .frame(width: 200, height: 100)
        //                            .overlay(Text(String(format: "%.2f", p)))
        //                    }
        //                }
        //            }
        //        }
        ZStack{
            Ellipse()
                .fill(Color.blue)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            
            GeometryReader { geometry in
                let rows = 4
                let columns = 3
                let dotSize: CGFloat = 30 // Size of each dot
                let spacing: CGFloat = 20 // Spacing between dots
                
                ForEach(0..<12) { index in
                    let row = index / columns
                    let column = index % columns
                    
                    // Calculate x and y positions for each dot
                    let xPosition = CGFloat(column) * (dotSize + spacing) + dotSize / 2
                    let yPosition = CGFloat(row) * (dotSize + spacing) + dotSize / 2
                    
                    // Ensure the dots are centered within the ellipse
                    let centerX = geometry.size.width / 2 - (CGFloat(columns) * (dotSize + spacing) - spacing) / 2
                    let centerY = geometry.size.height / 2 - (CGFloat(rows) * (dotSize + spacing) - spacing) / 2
                    
                    Circle()
                        .fill(interpolatedColor(for: points[index]))
                        .frame(width: dotSize, height: dotSize)
                        .position(x: centerX + xPosition, y: centerY + yPosition)
                }
            }
        }
    }
    
    func interpolatedColor(for value: Float) -> Color {
        let red = 1.0 - value // Red decreases as value increases
        let blue = value      // Blue increases as value increases
        return Color(red: Double(red), green: 0, blue: Double(blue))
    }
}


class OvalView: UIView {
    override func draw(_ rect: CGRect) {
        let ovalPath = UIBezierPath(ovalIn: rect)
        UIColor.blue.setFill()
        ovalPath.fill()
    }
}

#Preview {
    TopographyView()
}

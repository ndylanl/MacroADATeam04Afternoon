//
//  AnotatedImageView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 28/10/24.
//

import SwiftUI

struct AnnotatedImageView: View {
    let image: UIImage
    let detections: [DetectedObject]
    
    let labelColors: [Int: Color] = [
        1: .red,
        2: .blue,
        3: .green,
        4: .yellow,
        5: .white,
        6: .black
    ]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(uiImage: image)
                .resizable()
            //                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width*5/6,height: 300) // Maintain aspect ratio
            ForEach(detections) { object in
                let boxColor = labelColors[Int(object.label)!] ?? .clear //
                
                Rectangle()
                    .stroke(boxColor, lineWidth: 2)
                    .frame(width: object.boundingBox.width * UIScreen.main.bounds.width*4/5,
                           height: object.boundingBox.height * 275)
                    .offset(x: object.boundingBox.origin.x * UIScreen.main.bounds.width*4.2/5,
                            y: (1 - object.boundingBox.origin.y) * 275)
                
            }
        }
    }
}

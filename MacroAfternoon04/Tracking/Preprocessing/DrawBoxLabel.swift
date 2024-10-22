////
////  DrawBoxLabel.swift
////  MacroAfternoon04
////
////  Created by Nicholas Dylan Lienardi on 18/10/24.
////
//
////import Foundation
//import UIKit
//import SwiftUI
//
//struct AnnotatedImageView: View {
//    let image: UIImage
//    let detections: [DetectedObject]
//
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            Image(uiImage: image)
//                .resizable()
//                .scaledToFit()
//
//            ForEach(detections, id: \.index) { detection in
//                let coordinates = detection.coordinates
//                let rect = CGRect(
//                    x: coordinates.x,
//                    y: coordinates.y,
//                    width: coordinates.width,
//                    height: coordinates.height
//                )
//
//                // Overlay bounding box
//                Rectangle()
//                    .path(in: rect)
//                    .stroke(Color.red, lineWidth: 2)
//                    .overlay(
//                        Text("\(detection.label) (\(String(format: "%.2f", detection.confidence)))")
//                            .font(.caption)
//                            .foregroundColor(.red)
//                            .position(x: rect.midX, y: rect.minY - 10) // Position label above the box
//                    )
//            }
//        }
//    }
//}
//

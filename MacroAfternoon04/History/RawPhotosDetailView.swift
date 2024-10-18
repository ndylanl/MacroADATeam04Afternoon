//
//  RawPhotosDetailView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 18/10/24.
//

import SwiftUI

struct RawPhotosDetailView: View {
    @State var photo: Data
    @State var detections: [DetectedObject]
    @ObservedObject var viewModel: WeeklyReportViewModel
    
    var body: some View {
        if let uiImage = UIImage(data: photo){
            AnnotatedImageView(image: uiImage, detections: detections, viewModel: viewModel)
                .frame(width: UIScreen.main.bounds.width, height: 416)
            Text("Average Hair Per Follicle: \(String(format: "%.2", viewModel.totalAverageHair(targetObjectDetection: detections)))")
            LegendView()
                .frame(height: 100)
        }
    }
}

struct LegendView: View {
    var body: some View {
        HStack(spacing: 16) {
            Color.red.frame(width: 48)
                .overlay(Text("1"))
                .shadow(radius: 2)
                
            Color.purple.frame(width: 48)
                .overlay(Text("2"))
                .shadow(radius: 2)

            Color.blue.frame(width: 48)
                .overlay(Text("3"))
                .shadow(radius: 2)

            Color.green.frame(width: 48)
                .overlay(Text("4"))
                .shadow(radius: 2)

            Color.yellow.frame(width: 48)
                .overlay(Text("5"))
                .shadow(radius: 2)

        }
        .font(.headline)
        .foregroundColor(.black.opacity(0.7))
    }
}

struct AnnotatedImageView: View {
    let image: UIImage
    let detections: [DetectedObject]
    @ObservedObject var viewModel: WeeklyReportViewModel
    
    let labelColors: [Int: Color] = [
        1: .red,
        2: .purple,
        3: .blue,
        4: .green,
        5: .yellow,
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
                           height: object.boundingBox.height * 280)
                    .offset(x: object.boundingBox.origin.x * UIScreen.main.bounds.width*4/5,
                            y: (1 - object.boundingBox.origin.y) * 280)
                
            }
            
            // Draw bounding boxes
            //                    ForEach(detections, id: \.label) { object in
            //                        Rectangle()
            //                            .stroke(Color.red, lineWidth: 2)
            //                            .frame(width: object.boundingBox.width * UIScreen.main.bounds.width,
            //                                   height: object.boundingBox.height * 300)
            //                            .offset(x: object.boundingBox.origin.x * UIScreen.main.bounds.width - (UIScreen.main.bounds.width/2),
            //                                    y: (1 - object.boundingBox.origin.y) * 300 - 150)
            //                    }
            
        }
    }
}


//struct AnnotatedImageView: View {
//    let image: UIImage
//    let detections: [DetectedObject]
//
//    // Define colors for labels
//        let labelColors: [Int: Color] = [
//            1: .red,
//            2: .blue,
//            3: .green,
//            4: .yellow,
//            5: .white,
//            6: .black
//        ]
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .topLeading) {
//                // Calculate aspect ratio
//                let aspectRatio = image.size.width / image.size.height
//                let viewWidth = geometry.size.width
//                let viewHeight = geometry.size.height
//
//                // Calculate new dimensions based on aspect ratio
//                let scaledHeight = viewWidth / aspectRatio
//                //let scaledWidth = viewHeight / aspectRatio
//
//
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: viewWidth, height: min(scaledHeight, viewHeight)) // Maintain aspect ratio
//
//                ForEach(detections, id: \.index) { detection in
//                    let coordinates = detection.coordinates
//
//                    // Adjust bounding box coordinates based on scaling
//                    let rect = CGRect(
//                        x: coordinates.x * viewWidth,
//                        y: coordinates.y * min(scaledHeight, viewHeight),
//                        width: coordinates.width * viewWidth,
//                        height: coordinates.height * min(scaledHeight, viewHeight)
//                    )
//
////                    // Overlay bounding box
////                    if !(rect.origin.x + rect.width >= viewWidth) || (rect.origin.x + rect.width >= viewWidth) {
////                        if !(rect.origin.y + rect.height >= viewHeight) {
//                            let boxColor = labelColors[detection.label] ?? .clear //
//
//                            Rectangle()
//                                .path(in: rect)
//                                .stroke(boxColor, lineWidth: 2)
//                                .overlay(
//                                    Text("\(detection.label) (\(String(format: "%.3f", detection.confidence)))")
//                                        .font(.subheadline)
//                                        .foregroundColor(boxColor)
//                                        .position(x: rect.midX, y: rect.minY - 10) // Position label above the box
//                                )
////                        }
////                    }
//                }
//            }
//        }
//        .aspectRatio(contentMode: .fit) // Maintain aspect ratio of the entire view
//    }
//}

//
//  CameraView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 14/10/24.
//

import SwiftUI

struct CameraView: View {
    
    @Binding var image: CGImage?
    var onCapture: () -> Void
    var currentPage: Int
    var totalPages: Int
    
    @State private var showCaptureCue: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                
                AddProgressTrackingBarView(progress: currentPage)
                
                ZStack {
                    if let image = image {
                        ZStack {
                            Image(decorative: image, scale: 1)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width,
                                       height: geometry.size.width)
                            
                            Image("headOutline")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width,
                                       height: geometry.size.width)
                        }
                    } else {
                        ContentUnavailableView("Camera feed interrupted", systemImage: "xmark.circle.fill")
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                    }
                    
                    if showCaptureCue {
                        Color.black.opacity(0.5)
                            .transition(.opacity)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.width)
                    }
                }
                
                Text("Please place your head in the shape outlined above.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width * 333 / 430)
                
                Text("The Photo will be taken automatically once the right position has been taken.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .opacity(0.5)
                    .frame(width: UIScreen.main.bounds.width * 333 / 430)
                
                Button(action: {
                    showCaptureCue = true
                    onCapture()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        showCaptureCue = false
                    }
                }) {
                    Circle()
                        .frame(width: geometry.size.width / 8, height: geometry.size.width / 8)
                }
                .padding()
            }
        }
    }
}

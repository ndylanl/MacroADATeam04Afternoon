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
    @State private var tapLocation: CGPoint = .zero
    
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                
                AddProgressTrackingBarView(progress: currentPage)
                
                ZStack {
                    if let image = image {
                        
                        Image(decorative: image, scale: 1)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 32,
                                   height: UIScreen.main.bounds.width - 32)
                        
                    } else {
                        ContentUnavailableView("Camera feed interrupted", systemImage: "xmark.circle.fill")
                            .frame(width: UIScreen.main.bounds.width - 32,
                                   height: UIScreen.main.bounds.width - 32)
                    }
                    
                    if showCaptureCue {
                        Color.black.opacity(0.5)
                            .transition(.opacity)
                            .frame(width: UIScreen.main.bounds.width - 32,
                                   height: UIScreen.main.bounds.width - 32)
                    }
                }
                .padding()
                
                //                Slider(value: $viewModel.focusValue, in: 0...1, step: 0.01) {
                //                    Text("Focus")
                //                }
                //                .onChange(of: viewModel.focusValue) { newValue in
                //                    viewModel.updateFocus(value: newValue)
                //                }
                
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

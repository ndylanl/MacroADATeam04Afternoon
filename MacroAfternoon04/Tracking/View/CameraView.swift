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
    @State var totalPages: Int
    
    @State private var showCaptureCue: Bool = false
    @State private var tapLocation: CGPoint = .zero
    
    @State private var isAnimating = false
    
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                
                AddProgressTrackingBarView(progress: currentPage, viewModel: viewModel, totalPages: $totalPages)
                
                ZStack {
                    if let image = image {
                        
                        Image(decorative: image, scale: 1)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 32,
                                   height: UIScreen.main.bounds.width - 32)
                        
                    } else {
                        ContentUnavailableView("Please wait", systemImage: "camera.fill")
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
                
                
                VStack{
                    Text("Please bring the camera very close to the scalp until it looks clear enough.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                    
                    Text("Make sure you have a good lighting and another person to help take photos.")
                        .font(.body).opacity(0.5)
                        .multilineTextAlignment(.center)
                }.padding(.horizontal)
                
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)){
                        isAnimating.toggle()
                    }
                    showCaptureCue = true
                    onCapture()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        showCaptureCue = false
                    }
                }) {
                    Circle()
                        .stroke(Color("PrimaryColor"), lineWidth: 2)
                        .frame(width: UIScreen.main.bounds.width * 68 / 430, height: UIScreen.main.bounds.width * 68 / 430)
                        .overlay(
                            Circle()
                                .fill(Color("PrimaryColor"))
                                .frame(width: UIScreen.main.bounds.width * 60 / 430, height: UIScreen.main.bounds.width * 60 / 430)
                        )
                }
                .padding()
            }
        }
    }
}

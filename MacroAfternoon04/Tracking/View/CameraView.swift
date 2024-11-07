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
    
    @Binding var statusRetry: String
    
    var textColor: Color {
            switch statusRetry {
            case "Photo Done Successfully":
                return .green
            case "No Detections in Photo":
                return .red
            default:
                return .gray // Default color
            }
        }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                
                AddProgressTrackingBarView(progress: currentPage, viewModel: viewModel, totalPages: $totalPages)

                Text(statusRetry)
                    .foregroundColor(textColor)
                    .padding(.vertical, -10)

                ZStack {
                    if let image = image {
                        
                        CameraScalpPositionGuideView(selectedOption: $viewModel.currentScalpPosition)
                            .zIndex(2)
                            .offset(x: UIScreen.main.bounds.width/3.3, y: -UIScreen.main.bounds.width/3.8)
                        
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
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                    Text("Make sure you have a good lighting and another person to help take photos.")
                        .font(.footnote).opacity(0.5)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                }
                .padding(.horizontal)
                .padding(.horizontal)

                
                
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
                        .frame(width: UIScreen.main.bounds.width * 80 / 430, height: UIScreen.main.bounds.width * 80 / 430)
                        .overlay(
                            Circle()
                                .fill(Color("PrimaryColor"))
                                .frame(width: UIScreen.main.bounds.width * 72 / 430, height: UIScreen.main.bounds.width * 72 / 430)
                        )
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

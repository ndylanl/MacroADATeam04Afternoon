//
//  CameraViewModel.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 14/10/24.
//
import Foundation
import CoreImage
import Combine

class CameraViewModel: ObservableObject {
    @Published var currentFrame: CGImage?
    @Published var capturedImages: [CGImage] = []
    
    private let cameraManager = CameraManager()
    
    init() {
        Task {
            await handleCameraPreviews()
        }
    }
    
    func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
            }
        }
    }
    
    func captureImage() {
        if let currentFrame = currentFrame {
            capturedImages.append(currentFrame)
        }
    }
}

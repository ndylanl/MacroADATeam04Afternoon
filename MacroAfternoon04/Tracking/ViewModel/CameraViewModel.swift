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
    @Published var focusValue: Float = 0.5
    
    private let cameraManager = CameraManager()
    private var previewTask: Task<Void, Never>?
    
    init() {
        
    }
    
    func startCamera() {
        previewTask = Task {
            await handleCameraPreviews()
        }
    }
    
    func stopCamera() {
        previewTask?.cancel()
        previewTask = nil
        currentFrame = nil
    }
    
    func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
            }
        }
    }
    
    func updateFocus(value: Float) {
        cameraManager.setFocus(value: value)
    }
    
    func captureImage() {
        if let currentFrame = currentFrame {
            capturedImages.append(currentFrame)
        }
    }
}

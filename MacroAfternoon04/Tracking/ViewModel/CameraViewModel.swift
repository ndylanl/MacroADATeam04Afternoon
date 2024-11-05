//
//  CameraViewModel.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 14/10/24.
//
import Foundation
import CoreImage
import Combine
import SwiftUI
import UIKit
import SwiftData

class CameraViewModel: ObservableObject {
    @Published var currentFrame: CGImage?
    @Published var capturedImages: [CGImage] = []
    @Published var focusValue: Float = 0.5
    
    private let cameraManager = CameraManager()
    private var previewTask: Task<Void, Never>?
    
    var currentScalpPositions: [Int]
    var currentScalpPosition: Int

    var tempPic: [Data] = []
    var tempDetections: [DetectedObject] = []
    var tempAllDetection: [[DetectedObject]] = [[]]
    var tempHairData: [HairPictureData] = []
    
    init() {
        self.currentScalpPosition = 1
        self.currentScalpPositions = [1,2,3,4,5,6,7,8,9,10,11,12]
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
            print("FOTO")
            capturedImages.append(currentFrame)
            let uiImage = UIImage(cgImage: currentFrame)
            let data = uiImage.pngData()!
            tempHairData.append(HairPictureData(scalpArea: currentScalpPosition, hairPicture: [data]))

        }
    }
    
    func setPositions(){
        let optionsDict: [String: [Int]] = [
            "A. All Scalp": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
            "B. Left Side": [1, 4, 5, 7, 8, 10],
            "C. Right Side": [3, 5, 6, 8, 9, 12],
            "D. Front Side": [1, 2, 3, 4, 5, 6],
            "E. Middle Side": [3, 4, 5, 6, 7, 8],
            "F. Back Side": [7, 8, 9, 10, 11, 12],
        ]
        
        currentScalpPositions = optionsDict[UserDefaults.standard.string(forKey: "ScalpAreaChosen")!]!
        print("from set positions:\(currentScalpPositions)")
        currentScalpPosition = currentScalpPositions[0]
    }

}

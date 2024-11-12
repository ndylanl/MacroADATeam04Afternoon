//
//  HairFollicleDensityModel.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 17/10/24.
//

import Foundation
import UIKit
import CoreVideo
import Vision
import CoreML


func findMaxValueAndLabel(from multiArray: MLMultiArray) -> (maxValue: Double, label: String)? {
    // Ensure the multiArray is not empty
    if multiArray.count == 0 {
        return nil
    }
    
    let rows = multiArray.shape[0].intValue
    let columns = multiArray.shape[1].intValue
    
    // Ensure we have 6 columns as expected
    guard columns == 6 else {
        print("Expected 6 columns but found \(columns).")
        return nil
    }
    
    // Labels corresponding to columns
    let labels = ["1", "2", "3", "4", "5", "w"]
    
    var maxValue: Double = -Double.greatestFiniteMagnitude
    var maxLabel: String = ""
    
    // Iterate through the multiArray to find the maximum value and its label
    for i in 0..<rows {
        for j in 0..<columns {
            let index = i * columns + j
            let currentValue = multiArray[index].doubleValue
            
            // Update maxValue and label if currentValue is larger
            if currentValue > maxValue {
                maxValue = currentValue
                maxLabel = labels[j]
            }
        }
    }
    
    return (maxValue, maxLabel)
}

import UIKit
import Vision

func detectObjectsInImage(trackProgress: TrackProgressModel, confidenceThreshold: Float = 0.20) {
    // Iterate through each image in hairPicture
    print("DETECT OBJECTS IN IMAGE")
    
    for imageDataArray in trackProgress.hairPicture {
        var detectedObjects: [DetectedObject] = []
        
        for imageData in imageDataArray.hairPicture {
            guard let uiImage = imageData.toUIImage() else { continue }
            
            do {
                // Create a VNCoreMLModel from your ML model
                guard let model = try? VNCoreMLModel(for: NewModel().model) else { return }

                // Create a request for the model
                let request = VNCoreMLRequest(model: model) { (request, error) in
                    if let results = request.results as? [VNRecognizedObjectObservation] {
                        // Filter results based on the confidence threshold
                        detectedObjects = results.filter { observation in
                            observation.confidence >= confidenceThreshold
                        }.map { observation in
                            // Extract bounding box and label
                            let boundingBox = observation.boundingBox
                            let label = observation.labels.first?.identifier ?? "Unknown"

                            
                            return DetectedObject(id: UUID(), boundingBox: boundingBox, label: label)
                        }
                        
                        // Print detected objects for debugging
                        if detectedObjects.count > 8 {
                            // Add filtered detected objects to trackProgress.detections
                            trackProgress.detections.append(detectedObjects)
                            print("No objects detected above confidence threshold.")
                        } else {
                            print("Detected \(detectedObjects.count) objects above confidence threshold.")
                        }
                    } else if let error = error {
                        print("Error during request processing: \(error.localizedDescription)")
                    }
                }
                
                // Create an image request handler and perform the request
                let handler = VNImageRequestHandler(cgImage: uiImage.cgImage!, options: [:])
                try handler.perform([request])
                
            } catch {
                print("Error during image processing: \(error.localizedDescription)")
            }
            
        }
    }
}


func checkPicHasDetection(uiImage: UIImage, confidenceThreshold: Float = 0.20) -> Bool {
    var detectedObjects = 0
    
    do {
        // Create a VNCoreMLModel from your ML model
        guard let model = try? VNCoreMLModel(for: NewModel().model) else { return false }
        
        // Create a request for the model
        let request = VNCoreMLRequest(model: model) { (request, error) in
            if let results = request.results as? [VNRecognizedObjectObservation] {
                // Count detected objects that meet the confidence threshold
                detectedObjects = results.filter { observation in
                    // Check if the confidence of the observation is above the threshold
                    return observation.confidence >= confidenceThreshold
                }.count
                
                // Print detection status for debugging
                if detectedObjects > 8 {
                    print("TRUE: Detected \(detectedObjects) objects with sufficient confidence.")
                } else {
                    print("FALSE: No objects detected above confidence threshold.")
                }
            }
        }
        
        // Create an image request handler and perform the request
        let handler = VNImageRequestHandler(cgImage: uiImage.cgImage!, options: [:])
        try? handler.perform([request])
        
    } catch {
        print("Error during image processing: \(error)")
    }
    
    // Return true if any objects were detected above the confidence threshold
    return detectedObjects > 8
}


extension UIImage {
    func toCVPixelBuffer(size: Int) -> CVPixelBuffer? {
        let attrs = [
            kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
            kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue
        ] as CFDictionary
        
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            size,
            size,
            kCVPixelFormatType_32ARGB,
            attrs,
            &pixelBuffer
        )
        
        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(buffer, [])
        
        let pixelData = CVPixelBufferGetBaseAddress(buffer)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context = CGContext(
            data: pixelData,
            width: size,
            height: size,
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
            space: rgbColorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
        )
        
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        UIGraphicsPopContext()
        
        CVPixelBufferUnlockBaseAddress(buffer, [])
        
        return buffer
    }
}

extension Data {
    func toUIImage() -> UIImage? {
        return UIImage(data: self)
    }
}

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

//func detectObjectsInImage(trackProgress: TrackProgressModel) {
//    // Iterate through each image in hairPicture
//    print("DETECT OBJECTS IN IMAGE")
//    for imageDataArray in trackProgress.hairPicture {
//        var detectedObjects: [DetectedObject] = []
//        
//        for imageData in imageDataArray.hairPicture {
//            guard let uiImage = imageData.toUIImage() else { continue }
//            
//            do{
//                guard let model = try? VNCoreMLModel(for: NewModel().model) else { return }
//                
//                let request = VNCoreMLRequest(model: model) { (request, error) in
//                    if let results = request.results as? [VNRecognizedObjectObservation] {
//                        detectedObjects = results.map { observation in
//                            // Extract bounding box and label
//                            let boundingBox = observation.boundingBox
//                            let label = observation.labels.first?.identifier ?? "Unknown"
//
//                            let detectedObject = DetectedObject(id: UUID(), boundingBox: boundingBox, label: label)
//                            
//                            detectedObjects.append(detectedObject)
//                            return detectedObject
//                        }
//                    }
//                }
//                
//                let handler = VNImageRequestHandler(cgImage: uiImage.cgImage!, options: [:])
//                try? handler.perform([request])
//                
//            }
//            trackProgress.detections.append(detectedObjects)
//        }
//    }
//}

//func checkPicHasDetection(uiImage: UIImage) -> Bool{
//    var detectedObjects = 0
//    
//    do{
//        guard let model = try? VNCoreMLModel(for: NewModel().model) else { return false}
//        
//        let request = VNCoreMLRequest(model: model) { (request, error) in
//            if let results = request.results as? [VNRecognizedObjectObservation] {
//                detectedObjects = results.count { observation in
//                    // Extract bounding box and label
//                    if results.count > 0 {
//                        detectedObjects = results.count
//                        print("TRUE")
//                        return true
//                    } else {
//                        detectedObjects = 0
//                        print("FALSE")
//                        return false
//                    }
//                }
//            }
//        }
//        
//        let handler = VNImageRequestHandler(cgImage: uiImage.cgImage!, options: [:])
//        try? handler.perform([request])
//    }
//    
//    if detectedObjects > 0 {
//        return true
//    } else{
//        return false
//    }
//}

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
                        if detectedObjects.count > 10 {
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
                if detectedObjects > 10 {
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
    return detectedObjects > 10
}



//
//func processImages(trackProgress: TrackProgressModel) {
//    var allDetections: [[DetectedObject]] = []
//
//    // Iterate through each image in hairPicture
//    for imageDataArray in trackProgress.hairPicture {
//        var detectedObjects: [DetectedObject] = []
//
//        for imageData in imageDataArray {
//            guard let uiImage = imageData.toUIImage() else { continue }
//            let cvPixImage = uiImage.toCVPixelBuffer(size: 416)!
//
//            do{
//                let model = try best(configuration: MLModelConfiguration())
//                let prediction = try model.prediction(input: bestInput(imagePath: cvPixImage, iouThreshold: 0.85, confidenceThreshold: 0.019))
//
//
//                let numberOfRows = prediction.confidence.shape[0].intValue
//                let numberOfColumns = prediction.confidence.shape[1].intValue
//
//                // Define your labels
//                let labels: [Int] = [1, 2, 3, 4, 5, 6]
//
//                // Loop through each row of the MLMultiArray
//                for row in 0..<numberOfRows {
//                    for col in 0..<numberOfColumns {
//                        // Access the MLMultiArray element using its index
//                        //confidence is a multiarray double of all classes signifying confidence for all classes
//                        let confidence = prediction.confidence[row * numberOfColumns + col].doubleValue
//
//                        let x = prediction.coordinates[[NSNumber(value: row), NSNumber(value: 0)]].doubleValue
//                        let y = prediction.coordinates[[NSNumber(value: row), NSNumber(value: 1)]].doubleValue
//                        let width = prediction.coordinates[[NSNumber(value: row), NSNumber(value: 2)]].doubleValue
//                        let height = prediction.coordinates[[NSNumber(value: row), NSNumber(value: 3)]].doubleValue
//
//
//                        let coordinates = Coordinates(x: x, y: y, height: height, width: width)
//                        let detectedObject = DetectedObject(index: row, confidence: confidence, label: labels[col], coordinates: coordinates)
//                        detectedObjects.append(detectedObject)
//                        print(coordinates)
//                    }
//                    if !detectedObjects.isEmpty{
//                        trackProgress.detections.append(detectedObjects)
//                    } else {
//                        print("!!!!!!!")
//                        print("!!!!!!!")
//                        print("!!!!!!!")
//                        print("!!!!!!!")
//                        print("!!!!!!!")
//                    }
//                }
//
//
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        allDetections.append(detectedObjects)
//    }
//    // Assign detections back to the model
//    trackProgress.detections = allDetections
//}


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

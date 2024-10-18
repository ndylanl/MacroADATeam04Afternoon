//
//  CameraManager.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 14/10/24.
//

import AVFoundation
import CoreImage
import UIKit

class CameraManager: NSObject {
    
    private let captureSession = AVCaptureSession()
    
    private var deviceInput: AVCaptureDeviceInput?
    
    private var videoOutput: AVCaptureVideoDataOutput?
    
    private let systemPreferredCamera = AVCaptureDevice.default(for: .video)
    
    private var sessionQueue = DispatchQueue(label: "video.preview.session")
    
    private var addToPreviewStream: ((CGImage) -> Void)?
    
    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    private var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }
    
    override init() {
        super.init()
        
        Task {
            await configureSession()
            await startSession()
        }
    }
    
    private func configureSession() async {
        guard await isAuthorized,
              let ultraWideCamera = ultraWideCamera(), // Use the ultra-wide camera
              let deviceInput = try? AVCaptureDeviceInput(device: ultraWideCamera)
        else { return }
        
        captureSession.beginConfiguration()
        
        defer {
            self.captureSession.commitConfiguration()
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        
        guard captureSession.canAddInput(deviceInput) else {
            return
        }
        
        guard captureSession.canAddOutput(videoOutput) else {
            return
        }
        
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
    }
    
    private func startSession() async {
        guard await isAuthorized else { return }
        captureSession.startRunning()
    }
    
    private func rotate(by angle: CGFloat, from connection: AVCaptureConnection) {
        guard connection.isVideoRotationAngleSupported(angle) else { return }
        connection.videoRotationAngle = angle
    }
    
    private func cropToSquare(image: CGImage) -> CGImage? {
        let contextImage = UIImage(cgImage: image)
        let contextSize = contextImage.size
        
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        
        if contextSize.width > contextSize.height {
            posX = (contextSize.width - contextSize.height) / 2
            posY = 0
            width = contextSize.height
            height = contextSize.height
        } else {
            posX = 0
            posY = (contextSize.height - contextSize.width) / 2
            width = contextSize.width
            height = contextSize.width
        }
        
        let rect = CGRect(x: posX, y: posY, width: width, height: height)
        
        guard let imageRef = image.cropping(to: rect) else { return nil }
        
        let ciImage = CIImage(cgImage: imageRef)
        let resizedCIImage = ciImage.transformed(by: CGAffineTransform(scaleX: 416 / width, y: 416 / height))
        
        let ciContext = CIContext()
        guard let resizedCGImage = ciContext.createCGImage(resizedCIImage, from: CGRect(x: 0, y: 0, width: 416, height: 416)) else { return nil }
        
        return resizedCGImage
    }
    
    func focus(at point: CGPoint) {
        guard let device = systemPreferredCamera else { return }
        
        do {
            try device.lockForConfiguration()
            
            if device.isFocusPointOfInterestSupported {
                device.focusPointOfInterest = point
                device.focusMode = .autoFocus
            }
            
            if device.isExposurePointOfInterestSupported {
                device.exposurePointOfInterest = point
                device.exposureMode = .autoExpose
            }
            
            device.isSubjectAreaChangeMonitoringEnabled = true
            
            device.unlockForConfiguration()
        } catch {
            print("Error locking configuration: \(error)")
        }
    }
    
    func setFocus(value: Float) {
        guard let device = systemPreferredCamera else { return }
        
        do {
            try device.lockForConfiguration()
            device.setFocusModeLocked(lensPosition: value, completionHandler: nil)
            device.unlockForConfiguration()
        } catch {
            print("Error setting focus: \(error)")
        }
    }
    
    private func ultraWideCamera() -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInUltraWideCamera],
            mediaType: .video,
            position: .back
        )
        return discoverySession.devices.first
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let currentFrame = sampleBuffer.cgImage else {
            print("Can't translate to CGImage")
            return
        }
        
        if let videoConnection = output.connection(with: .video) {
            videoConnection.videoRotationAngle = 90
        }
        
        if let croppedImage = cropToSquare(image: currentFrame) {
            addToPreviewStream?(croppedImage)
        }
    }
}

extension CMSampleBuffer {
    var cgImage: CGImage? {
        let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(self)
        guard let imagePixelBuffer = pixelBuffer else { return nil }
        return CIImage(cvPixelBuffer: imagePixelBuffer).cgImage
    }
}

extension CIImage {
    var cgImage: CGImage? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
        return cgImage
    }
}

//
//  AddProgressCameraSheetView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 10/10/24.
//

import SwiftUI
import UIKit
import SwiftData


struct AddProgressCameraSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject private var viewModel = CameraViewModel()
    
    @State private var currentPage = 1

    @State var totalPages = 3
    
    @State var statusRetry: String = "Begin Taking Pictures"
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                CameraView(image: $viewModel.currentFrame, onCapture: captureImage, currentPage: currentPage, totalPages: totalPages, viewModel: viewModel)
                    .ignoresSafeArea()
                Text(statusRetry)
            }
            .onAppear {
                viewModel.startCamera()
                viewModel.setPositions()
                totalPages = viewModel.currentScalpPositions.count
            }
            .onDisappear {
                viewModel.stopCamera()
            }
            .navigationTitle("Hair Growth Progress")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private func captureImage() {
        if checkPicHasDetection(uiImage: UIImage(cgImage: viewModel.currentFrame!)){
            viewModel.captureImage()
            if currentPage < totalPages {
                currentPage += 1
                viewModel.currentScalpPosition = viewModel.currentScalpPositions[currentPage - 1]
            } else {
                saveImages()
                presentationMode.wrappedValue.dismiss()
            }
            statusRetry = "Photo Done Successfully"
        } else {
            statusRetry = "No Detections in Photo"
        }
    }
    
    private func saveImages() {
        let trackProgressModel = TrackProgressModel(hairPicture: viewModel.tempHairData, detections: [[]])
        
        detectObjectsInImage(trackProgress: trackProgressModel)
        
        // Save trackProgressModel to your SwiftData context
        saveToModel(trackProgressModel)
        

        }
    
    private func saveToModel(_ model: TrackProgressModel) {
        modelContext.insert(model)
        do {
            try modelContext.save()
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
    
}

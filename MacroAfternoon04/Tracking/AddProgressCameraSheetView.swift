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
    
    private let totalPages = 3
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                CameraView(image: $viewModel.currentFrame, onCapture: captureImage, currentPage: currentPage, totalPages: totalPages)
                    .ignoresSafeArea()
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
        viewModel.captureImage()
        if currentPage < totalPages {
            currentPage += 1
        } else {
            saveImages()
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func saveImages() {
        let hairPictures = viewModel.capturedImages.map { cgImage in
            let uiImage = UIImage(cgImage: cgImage)
            let data = uiImage.pngData()!
            return [data]
        }
        let trackProgressModel = TrackProgressModel(hairPicture: hairPictures)
        
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

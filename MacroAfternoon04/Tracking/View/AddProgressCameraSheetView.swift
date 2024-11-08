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
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var showingAddProgressSheet: Bool
    
    @Binding var selectedDay: Int
    
    @StateObject private var viewModel = CameraViewModel()
    
    @State private var currentPage = 1
    
    @State var totalPages = 0
    
    @State var statusRetry: String = "Begin Taking Pictures"
    
    @Query private var reminders: [ReminderModel]         // Query reminders from SwiftData
    
    @StateObject var healthViewModel = HealthViewModel() // Integrasi HealthViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                CameraView(image: $viewModel.currentFrame, onCapture: captureImage, currentPage: currentPage, totalPages: $totalPages, viewModel: viewModel, statusRetry: $statusRetry)
                    .ignoresSafeArea()
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
                        showingAddProgressSheet = false
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
                showingAddProgressSheet = false
            }
            statusRetry = "Photo Done Successfully"
        } else {
            statusRetry = "No Detections in Photo"
        }
    }
    
    private func calcPoints(points: [Int]) -> Int{
        let intToReturn = 100
        
        var sum = 0 // Initialize sum to zero
        
        // Iterate through each score in the array
        for score in points {
            if score < 100 {
                let difference = 100 - score // Calculate the difference
                sum += difference // Add the difference to the sum
            }
        }
        
        return (intToReturn - sum)
        
    }
    
    private func saveImages() {
        let trackProgressModel = TrackProgressModel(hairPicture: viewModel.tempHairData, detections: [[]], scalpPositions: UserDefaults.standard.string(forKey: "ScalpAreaChosen")!, appointmentPoint: calcPoints(points:reminders.compactMap{$0.appointmentPoint}), applyPoint: calcPoints(points:reminders.compactMap{$0.applyPoint}), consumePoint: calcPoints(points:reminders.compactMap{$0.consumePoint}), exercisePoint: calcPoints(points:reminders.compactMap{$0.exercisePoint}), otherPoint: calcPoints(points:reminders.compactMap{$0.otherPoint}))
        
        detectObjectsInImage(trackProgress: trackProgressModel)
        
        addProgressNotification(selectedDay: selectedDay)
        
        // Save trackProgressModel to your SwiftData context
        saveToModel(trackProgressModel)
        
        presentationMode.wrappedValue.dismiss()
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

//
//  HistoryViewModel.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 28/10/24.
//

import Foundation
import SwiftData
import Combine

class HistoryViewModel: ObservableObject {
    
    var modelContext: ModelContext
    var trackProgress: [TrackProgressModel] = []
    var uniqueMonths: [Date] = []
    @Published var annotatedImagesData: [(photo: Data, detections: [DetectedObject])] = []
    
    init(modelContext: ModelContext){
        self.modelContext = modelContext
        fetchTrackProgress()
    }
    
    func fetchTrackProgress() {
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: nil,
            sortBy: [SortDescriptor(\.dateTaken, order: .reverse)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)
            self.trackProgress = models
            self.uniqueMonths = Array(Set(models.map { Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: $0.dateTaken))! })).sorted(by: >)
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
    
    func fetchAnnotatedImagesData(for date: Date) {
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: #Predicate { $0.dateTaken == date },
            sortBy: [SortDescriptor(\.dateTaken, order: .reverse)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)
            if let model = models.first {
                for i in 0..<model.hairPicture.count {
                    self.annotatedImagesData.append((photo: model.hairPicture[i].hairPicture[0], detections: model.detections[i]))
                }
//                self.annotatedImagesData = model.hairPicture.enumerated().flatMap { (index, photoArray) in
//                    photoArray.map { photo in
//                        (photo: photo, detections: model.detections[index])
//                    }
//                }
            }
        } catch {
            print("Failed to fetch annotated images data: \(error)")
        }
    }
}

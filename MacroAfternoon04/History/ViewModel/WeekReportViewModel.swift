////
////  WeekReportViewModel.swift
////  MacroAfternoon04
////
////  Created by Nicholas Dylan Lienardi on 31/10/24.
//
//
//import Foundation
//import SwiftUI
//import Combine
//import SwiftData
//
//class WeekReportViewModel: ObservableObject {
//    
//    @Published var photos: [Data] = []
//    @Published var detections: [[DetectedObject]] = [[]]
//    @Published var progressModels: [TrackProgressModel] = []
//    private var cancellables = Set<AnyCancellable>()
//    var modelContext: ModelContext
//    
//    init(modelContext: ModelContext) {
//        self.modelContext = modelContext
//        fetchProgressData()
//    }
//    
//    func fetchProgressData() {
//        let fetchRequest = FetchDescriptor<TrackProgressModel>(
//            predicate: nil,
//            sortBy: [SortDescriptor(\.dateTaken, order: .reverse)]
//        )
//        
//        do {
//            let models = try modelContext.fetch(fetchRequest)
//            self.progressModels = models
//        } catch {
//            print("Failed to fetch data: \(error)")
//        }
//    }
//    
//    func fetchAnnotatedImagesData(for date: Date) {
//        let fetchRequest = FetchDescriptor<TrackProgressModel>(
//            predicate: #Predicate { $0.dateTaken == date },
//            sortBy: [SortDescriptor(\.dateTaken, order: .reverse)]
//        )
//        
//        do {
//            let models = try modelContext.fetch(fetchRequest)
//            if let model = models.first {
//                for i in 0..<model.hairPicture.count {
//                    photos.append(model.hairPicture[i].hairPicture[0])
//                    // CHECK SEMUA GAMBAR MASUK AND BISA DITAMPIL GA HABIS GANTI FORMAT HAIRPICTURE
//                    
//                    
//                    
//                    
//                }
//            }
//        } catch {
//            print("Failed to fetch annotated images data: \(error)")
//        }
//    }
//}

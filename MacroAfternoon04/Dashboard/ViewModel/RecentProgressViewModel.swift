//
//  RecentProgressViewModel.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 17/10/24.
//

import Foundation
import Combine
import SwiftData

class RecentProgressViewModel: ObservableObject {
    @Published var lastDate: Date = Date()
    @Published var lastPhotos: [Data] = []
    
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchLastData()
    }
    
    func fetchLastData() {
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: nil,
            sortBy: [SortDescriptor(\.dateTaken, order: .reverse)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)
            guard let lastModel = models.first else { return }
            
            self.lastPhotos = lastModel.hairPicture.flatMap { $0.hairPicture }
            self.lastDate = lastModel.dateTaken
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}

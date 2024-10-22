//
//  ComparisonResultViewModel.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 21/10/24.
//

import Foundation
import SwiftData
import Combine

class ComparisonResultViewModel: ObservableObject {
    @Published var trackProgressData: [TrackProgressModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.fetchData()
    }
    
     func fetchData() {
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: nil,
            sortBy: [SortDescriptor(\.dateTaken, order: .forward)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)
            self.trackProgressData = models
            print(trackProgressData)
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}

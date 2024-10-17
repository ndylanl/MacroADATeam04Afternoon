//
//  CompareProgressViewModel.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 17/10/24.
//

import Foundation
import Combine
import SwiftData

class CompareProgressViewModel: ObservableObject {
    @Published var progressModels: [TrackProgressModel] = []
    private var cancellables = Set<AnyCancellable>()
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchProgressData()
    }
    
    func fetchProgressData() {
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: nil,
            sortBy: [SortDescriptor(\.dateTaken, order: .reverse)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)
            self.progressModels = models
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}

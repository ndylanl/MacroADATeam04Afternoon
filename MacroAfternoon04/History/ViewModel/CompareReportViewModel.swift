//
//  CompareReportViewModel.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 29/10/24.
//

import Foundation
import Combine
import SwiftData

class CompareReportViewModel: ObservableObject {
    @Published var availableDates: [Date] = []
    @Published var selectedReportA: Date? = nil
    @Published var selectedReportB: Date? = nil
    
    private var cancellables = Set<AnyCancellable>()
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchAvailableDates()
    }
    
    func fetchAvailableDates() {
        let fetchRequest = FetchDescriptor<TrackProgressModel>(
            predicate: nil,
            sortBy: [SortDescriptor(\.dateTaken, order: .reverse)]
        )
        
        do {
            let models = try modelContext.fetch(fetchRequest)
            self.availableDates = models.map { $0.dateTaken }
            
            if let firstDate = availableDates.first {
                if selectedReportA == nil {
                    selectedReportA = firstDate
                }
                if selectedReportB == nil {
                    selectedReportB = firstDate
                }
            }
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}

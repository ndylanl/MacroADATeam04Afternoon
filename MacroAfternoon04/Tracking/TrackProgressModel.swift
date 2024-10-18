//
//  TrackProgressModel.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 14/10/24.
//

import Foundation
import SwiftData

@Model
class TrackProgressModel: Identifiable {
    @Attribute(.unique) var id: UUID
    var hairPicture: [[Data]]
    var dateTaken: Date
    
    init(hairPicture: [[Data]]) {
        self.id = UUID()
        self.hairPicture = hairPicture
        self.dateTaken = Date()
    }
}

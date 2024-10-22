//
//  TrackProgressModel.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 14/10/24.
//

import Foundation
import SwiftData


struct DetectedObject: Encodable,Decodable, Identifiable {
    var id : UUID
    var boundingBox: CGRect
    var label: String
}

// Define a struct for coordinates
struct Coordinates: Encodable, Decodable {
    var x: Double
    var y: Double
    var height: Double
    var width: Double
}

@Model
class TrackProgressModel: Identifiable {
    @Attribute(.unique) var id: UUID
    var hairPicture: [[Data]]
    var dateTaken: Date
    var detections: [[DetectedObject]] // Array of detected objects for each image
    
    init(hairPicture: [[Data]], detections: [[DetectedObject]]) {
        self.id = UUID()
        self.hairPicture = hairPicture
        self.dateTaken = Date()
        self.detections = detections
    }
}

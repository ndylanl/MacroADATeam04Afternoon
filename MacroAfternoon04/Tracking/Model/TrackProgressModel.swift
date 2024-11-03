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
class HairPictureData: RandomAccessCollection {
    
    // Properties for hair data
    var scalpArea: Int
    var hairPicture: [Data]
    
    // Required initializer
    required init(scalpArea: Int, hairPicture: [Data]) {
        self.scalpArea = scalpArea
        self.hairPicture = hairPicture
    }
    
    // MARK: - RandomAccessCollection Requirements
    
    // The type of the collection's elements.
    typealias Element = Data
    
    // The index type used by the collection.
    typealias Index = Int

    // The starting index of the collection.
    var startIndex: Int {
        return hairPicture.startIndex
    }

    // The collection's "one past the end" index.
    var endIndex: Int {
        return hairPicture.endIndex
    }

    // A subscript that retrieves the element at the specified index.
    subscript(index: Int) -> Data {
        return hairPicture[index]
    }

    // A method to advance the given index by a specified number of positions.
    func index(after i: Int) -> Int {
        return hairPicture.index(after: i)
    }
}



@Model
class TrackProgressModel: Identifiable {
    @Attribute(.unique) var id: UUID
    //var hairPicture: [[Data]]
    var hairPicture: [HairPictureData]
    var dateTaken: Date
    var detections: [[DetectedObject]] // Array of detected objects for each image
    //var scalpPositions: [Int] = []
    
    init(hairPicture: [HairPictureData], detections: [[DetectedObject]]) {
        self.id = UUID()
        self.hairPicture = hairPicture
        self.dateTaken = Date()
        self.detections = detections
    }
}

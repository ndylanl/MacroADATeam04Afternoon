//
//  RecentProgressView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 15/10/24.
//

import SwiftUI
import SwiftData

struct RecentProgressView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var trackProgressModels: [TrackProgressModel]
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePreviewPresented: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(groupedByDate(), id: \.key) { date, models in
                    Section(header: Text(date, style: .date)) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                            ForEach(models, id: \.id) { model in
                                ForEach(model.hairPicture, id: \.self) { imageDataArray in
                                    ForEach(imageDataArray, id: \.self) { imageData in
                                        if let uiImage = UIImage(data: imageData) {
                                            NavigationLink(destination: ImagePreviewView(image: uiImage)) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 100, height: 100)
                                                    .clipped()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    private func groupedByDate() -> [(key: Date, value: [TrackProgressModel])] {
        let groupedDictionary = Dictionary(grouping: trackProgressModels) { model in
            Calendar.current.startOfDay(for: model.dateTaken)
        }
        return groupedDictionary.sorted { $0.key > $1.key }
    }
}

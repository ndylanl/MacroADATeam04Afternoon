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
    @StateObject private var viewModel: RecentProgressViewModel
    
    init(viewModel: RecentProgressViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("Recent Progress")
                .font(.title)
            
            Text("Date: \(viewModel.lastDate)")
                .font(.subheadline)
            
            ScrollView {
                ForEach(viewModel.lastPhotos, id: \.self) { photoData in
                    if let uiImage = UIImage(data: photoData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchLastData()
        }
    }
}

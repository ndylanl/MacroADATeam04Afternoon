//
//  CompareProgressView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 17/10/24.
//

import SwiftUI

struct CompareProgressView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: CompareProgressViewModel
    
    
    init(viewModel: CompareProgressViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.progressModels, id: \.id) { model in
                    VStack {
                        Text("Date: \(DateFormatter.localizedString(from: model.dateTaken, dateStyle: .short, timeStyle: .none))")
                            .font(.subheadline)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(model.hairPicture, id: \.self) { photoDataArray in
                                    ForEach(photoDataArray, id: \.self) { photoData in
                                        if let uiImage = UIImage(data: photoData) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .padding()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchProgressData()
        }
    }
}
//
//#Preview {
//    CompareProgressView(viewModel: <#CompareProgressViewModel#>)
//}

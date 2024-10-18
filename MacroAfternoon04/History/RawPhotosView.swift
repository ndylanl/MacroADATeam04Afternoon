//
//  RawPhotosView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 17/10/24.
//

import SwiftUI

struct RawPhotosView: View {
    @ObservedObject var viewModel: WeeklyReportViewModel
    
    var body: some View {
        NavigationView{
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(Array(viewModel.photos.enumerated()), id: \.element) { index, photoData in
                            if let uiImage = UIImage(data: photoData) {
                                NavigationLink(destination: RawPhotosDetailView(photo: photoData, detections: viewModel.detections[index], viewModel: viewModel)) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                }
                            }
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
        }
        .navigationTitle("Raw Photos")
        .navigationBarTitleDisplayMode(.large)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button("Select"){
                    print("Not yet implemented")
                }
            }
        }
    }
}


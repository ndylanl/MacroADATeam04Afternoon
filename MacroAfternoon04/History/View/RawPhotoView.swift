//
//  RawPhotoView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 29/10/24.
//

import SwiftUI

struct RawPhotoView: View {
    
    var photos: [Data]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(photos, id: \.self) { photoData in
                        if let uiImage = UIImage(data: photoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: photoSize(), height: photoSize())
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
            
        }
        .navigationTitle("Raw Photos")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private func photoSize() -> CGFloat {
        UIScreen.main.bounds.width * 122 / 430
    }
}

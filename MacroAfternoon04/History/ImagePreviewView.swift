//
//  ImagePreviewView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 15/10/24.
//

import SwiftUI

struct ImagePreviewView: View {
    let image: UIImage
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
        }
        .background(Color.black.opacity(0.8))
        .edgesIgnoringSafeArea(.all)
    }
}

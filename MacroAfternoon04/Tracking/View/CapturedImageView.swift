//
//  CapturedImageVIew.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 15/10/24.
//

import SwiftUI

struct CapturedImageView: View {
    let image: CGImage
    
    var body: some View {
        Image(decorative: image, scale: 1)
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.width)
            .navigationTitle("Captured Image")
    }
}

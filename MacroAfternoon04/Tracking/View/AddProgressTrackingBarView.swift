//
//  AddProgressTrackingBarView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 15/10/24.
//

import SwiftUI

struct AddProgressTrackingBarView: View {
    var progress: Int
    @ObservedObject var viewModel: CameraViewModel

    
    var body: some View {
        HStack{
            ForEach(1..<$viewModel.currentScalpPositions.count){ i in
                Capsule()
                    .fill(progress < i ? Color.gray : Color.blue)
                    .frame(width: UIScreen.main.bounds.width / 7, height: 10)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 68 / 932)
    }
}


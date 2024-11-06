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

    @Binding var totalPages: Int
    
    var body: some View {
        HStack{
            ForEach(1..<13){ i in
                Capsule()
                    .fill(progress > i ? Color("PrimaryColor") : Color.gray)
                    .frame(width: UIScreen.main.bounds.width / 24 , height: 10)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 68 / 932)
    }
}

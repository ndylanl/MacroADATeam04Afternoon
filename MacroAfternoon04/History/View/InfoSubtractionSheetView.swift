//
//  InfoSubtractionSheetView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 29/10/24.
//

import SwiftUI

struct InfoSubtractionSheetView: View {

    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView{
            VStack (alignment: .leading){
                Text("How do we get this result?")
                    .font(.title2).bold()
                
                Text("The topography shown on monthly report is the result of subtraction between the topography of the fourth and the first week of the month. ")
                    .font(.body)
                    .padding(.top, 8)
             
                Spacer()
            }
            .padding(.vertical, 42)
            .frame(width: UIScreen.main.bounds.width * 374 / 430)
            .navigationTitle("Subtraction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Done"){
                        isPresented = false
                    }
                }
            }
        }
    }
}

//#Preview {
//    InfoSubtractionSheetView(isPresented: .constant(true))
//}

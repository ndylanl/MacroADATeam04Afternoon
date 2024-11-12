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
            ScrollView{
                VStack (alignment: .leading){
                    Text("How do we get this result?")
                        .font(.title2).bold()
                    
                    Text("""
                    
                    The topography shown on monthly report is the result of subtraction between the topography of the fourth and the first week of the month. 
                    
                    Our hair growth journey app is built on the foundation of advanced research, particularly the study by Kim et al. (2022), which developed a state-of-the-art system for hair follicle classification and hair loss severity estimation using Mask R-CNN technology. This technology, along with precise classification criteria, ensures users receive an accurate understanding of their hair condition.
                    
                    The article utilizes Mask R-CNN, a multitask learning AI that detects and localizes hair follicles while assessing hair loss severity. This offers users high-accuracy insights comparable to clinical tools.
                    
                    The app classifies hair follicles based on our main criteria: number of hairs per follicle, with the classification:
                    Healthy: 3 or more hairs.
                    Normal: 2 hair.
                    Severe: 1 hair.
                    
                    Significance: Multiple hairs per follicle indicate good follicle health, while single-hair follicles may suggest issues.
                    
                    With the data that user input, our app then generate detailed heatmaps about the hair growth condition on chosen areas of scalp for tracking. These visualizations enhance the user experience by offering an intuitive representation of hair loss and growth condition across different scalp regions, making complex data easier to interpret. This feature ensures users gain clear, actionable insights into their hair health, supporting informed decision-making for their hair growth journey.
                    
                    """)
                    
                    Spacer()
                }
                .padding(.vertical, 42)
                
            }
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


//
//  CameraScalpPositionGuideView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 05/11/24.
//

import SwiftUI

struct CameraScalpPositionGuideView: View {
    let optionsDict: [Int: String] = [
        1: "1",
        2: "2",
        3: "3",
        4: "4",
        5: "5",
        6: "6",
        7: "7",
        8: "8",
        9: "9",
        10: "10",
        11: "11",
        12: "12",
    ]
    
    let optionsFileDict: [String: String] = [
        "A. All Scalp": "ScalpFull",
        "B. Left Side": "ScalpLeft",
        "C. Right Side": "ScalpRight",
        "D. Front Side": "ScalpTop",
        "E. Middle Side": "ScalpMiddle",
        "F. Back Side": "ScalpBottom",
    ]
    
    @Binding var selectedOption: Int
    
    var body: some View {
        
        Image("scalpPositions\(optionsFileDict[UserDefaults.standard.string(forKey: "ScalpAreaChosen")!]!)\(optionsDict[selectedOption]!)")
            .resizable() // Make the image resizable
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width/4)
        //Text("scalpPositions\(optionsFileDict[UserDefaults.standard.string(forKey: "ScalpAreaChosen")!]!)\(optionsDict[selectedOption]!)")
        
    }
        
}

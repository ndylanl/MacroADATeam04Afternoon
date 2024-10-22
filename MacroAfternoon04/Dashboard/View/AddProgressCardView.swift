//
//  AddProgressView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 09/10/24.
//m

import SwiftUI

struct AddProgressCardView: View {
    
    var body: some View {
        ZStack(){
            RoundedCornerComponentView()
            
            Image(systemName: "camera.fill")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .frame(width: IconWidthSize(), height: IconHeightSize())
            
        }
        .frame(width: cardWidthSize(), height: cardHeightSize())
    }
    
    func cardWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 112 / 430)
    }
    
    func cardHeightSize() ->CGFloat{
        (UIScreen.main.bounds.height * 112 / 985)
    }
    
    func IconWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 82 / 430)
    }
    
    func IconHeightSize() -> CGFloat{
        (UIScreen.main.bounds.height * 67 / 985)
    }
    
}

#Preview {
    AddProgressCardView()
}

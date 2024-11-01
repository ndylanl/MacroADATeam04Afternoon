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
                .foregroundStyle(Color("PrimaryColor"))
                .frame(width: IconWidthSize(), height: IconHeightSize())
            
        }
        .background(Color("SecondaryColor"))
        .frame(width: cardWidthSize(), height: cardHeightSize())
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("PrimaryColor"), lineWidth: 0.5)
        )
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

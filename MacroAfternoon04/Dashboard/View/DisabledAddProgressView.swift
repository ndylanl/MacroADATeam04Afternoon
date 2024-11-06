//
//  DisabledAddProgressView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 05/11/24.
//

import SwiftUI

struct DisabledAddProgressView: View {
    
    var body: some View{
        ZStack(){
            //RoundedCornerComponentView()
            
            RoundedCornerComponentBlueView()
            
            Image("DisabledAddProgress")
                    .resizable()
//                .font(.system(size: 17, weight: .regular))
//                .foregroundStyle(Color("NeutralColor"))
                .frame(width: IconWidthSize(), height: IconHeightSize())
            
            
            
        }
        //.background(Color("SecondaryColor"))
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

#Preview {
    DisabledAddProgressView()
}

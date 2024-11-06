//
//  DisabledAddProgressView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 05/11/24.
//

import SwiftUI

struct DisabledAddProgressView: View {
    
    @Binding var daysLeft: Int
    
    var body: some View{
        ZStack(){
            //RoundedCornerComponentView()
            
            RoundedCornerComponentGrayView()
            
            VStack{
                Image(systemName: "camera.fill")
                    .font(.title3)
                
                Text("Add Progress \(daysLeft) Days Left")
                    .font(.caption2)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(Color("NeutralColor"))
            .frame(width: IconWidthSize(), height: IconHeightSize())
            
            
            
        }
        //        .background(Color.white)
        .frame(width: cardWidthSize(), height: cardHeightSize())
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("NeutralColor"), lineWidth: 0.5)
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
    DisabledAddProgressView(daysLeft: .constant(1))
}

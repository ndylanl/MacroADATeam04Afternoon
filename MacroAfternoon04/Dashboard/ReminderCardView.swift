//
//  ReminderCardView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 09/10/24.
//

import SwiftUI

struct ReminderCardView: View {
    var body: some View {
        ZStack(){
            RoundedCornerComponentView()
            
            VStack(alignment: .leading){
                Text("Reminder")
                    .font(.footnote)
                    .foregroundStyle(.black)
                
                Divider()
                
                Text("+ Add New Reminder")
                    .font(.title)
                
                Text("You have no reminder yet")
                    .font(.body)
            }
            .foregroundStyle(Color.primary)
            .frame(width: cardWidthSize() - 32, height: cardHeightSize() - 24)
        }
        .frame(width: cardWidthSize(), height: cardHeightSize())
    }
    
    func cardWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 374 / 430)
    }
    
    func cardHeightSize() ->CGFloat{
        (UIScreen.main.bounds.height * 142 / 985)
    }
    
    //    func buttonWidth(item: CalcButton) -> CGFloat {
    //            (UIScreen.main.bounds.width - (5 * 12)) / 4
    //        }
}

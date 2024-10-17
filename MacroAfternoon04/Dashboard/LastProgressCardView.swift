//
//  LastProgressCardView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 09/10/24.
//

import SwiftUI

struct LastProgressCardView: View {
    
    var body: some View {
        ZStack(){
            RoundedCornerComponentView()
            
            VStack(alignment: .center){
                Image("placeholderDashboardLastProgressCard")
                    .resizable()
                    .frame(width: cardPhotoWidthSize() , height: cardPhotoHeightSize())

                HStack{
                    Text("Recent Progress")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                    .font(.body)
                    .padding(.bottom, 12)
                
            }
            .padding(12)
            .foregroundStyle(Color.primary)
            .background(Color.white)
            .frame(width: cardWidthSize(), height: cardHeightSize())
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .frame(width: cardWidthSize(), height: cardHeightSize(), alignment: .bottom)
    }
    
    func cardWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 214 / 430)
    }
    
    func cardHeightSize() ->CGFloat{
        (UIScreen.main.bounds.height * 112 / 985)
    }
    
    func cardPhotoWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 214 / 430)
    }
    
    func cardPhotoHeightSize() -> CGFloat{
        (UIScreen.main.bounds.height * 69 / 985)
    }
    
    func cardRecentHeightSize() -> CGFloat{
        (UIScreen.main.bounds.height * 112 / 985)
    }
    
    func cardRecentWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 214 / 430)
    }
}

//#Preview {
//    LastProgressCardView()
//}

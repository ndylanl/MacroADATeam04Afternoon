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
//                ZStack{
//                    RoundedCornerComponentView()
//                        .background(Color.white)
                
//                    Text("🫧📖🤷📖🫧")
//    //                    .resizable()
//                        .font(.title3)
//                        .frame(width: cardPhotoWidthSize() , height: cardPhotoHeightSize())
//                        .background(Color.white)
                    
//                }
                

                VStack{
                    Image("PlaceholderDashboardRecent")
                        .resizable()
                }
                .frame(width: cardPhotoWidthSize() , height: cardPhotoHeightSize())
                .background(Color.white)

                HStack{
                    Image(systemName: "doc.text.fill")
                    Text("Recent Report")
                        
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .font(.body)
                    .padding(.bottom, 12)
                    .foregroundStyle(Color("PrimaryColor"))
                
            }
            .padding(12)
            .foregroundStyle(Color.primary)
            .background(Color("SecondaryColor"))
            .frame(width: cardWidthSize(), height: cardHeightSize())
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("PrimaryColor"), lineWidth: 0.5))
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
        (UIScreen.main.bounds.width * 212 / 430)
    }
    
    func cardPhotoHeightSize() -> CGFloat{
        (UIScreen.main.bounds.height * 66 / 985)
    }
    
    func cardRecentHeightSize() -> CGFloat{
        (UIScreen.main.bounds.height * 112 / 985)
    }
    
    func cardRecentWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 214 / 430)
    }
}

#Preview {
    LastProgressCardView()
}

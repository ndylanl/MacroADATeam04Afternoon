//
//  YourActivityCardView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 09/10/24.
//

import SwiftUI

struct YourActivityCardView: View {
    var body: some View {
        ZStack(){
            Image("placeholderDashboardYourActivityCard")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 18))
            
            VStack(alignment: .leading){
                Text("Your Activity")
                    .font(.footnote)
                
                Divider()
                
                AnyLayout(HStackLayout()){
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("42")
                                .font(.title)
                            Text("hrs")
                                .font(.subheadline)
                        }
                        Text("🌙 Sleep Time")
                            .font(.caption2)
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Text("100")
                                .font(.title)
                            Text("pts")
                                .font(.subheadline)
                        }
                        Text("😀 Stress Level")
                            .font(.caption2)
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Text("100")
                                .font(.title)
                            Text("pts")
                                .font(.subheadline)
                        }
                        Text("🏃 Movement")
                            .font(.caption2)
                    }
                }
                
                ZStack{
                    RoundedCornerComponentView()
                    
                    VStack(alignment: .leading){
                        Text("💡 Tips")
                            .font(.subheadline)
                        Text("Apply shampoo to your scalp, instead of the entire length of your hair. This way, you cleanse and wash away built-up products, dead skin, and excess oil, but avoid drying your hair too much.")
                            .font(.body)
                    }.padding(12)
                }
                .frame(width: cardWidthSize() - 32, height: UIScreen.main.bounds.height * 159 / 985)
            }
            .frame(width: cardWidthSize()-32, alignment: .center)
        }
        .frame(width: cardWidthSize(), height: cardHeightSize())
    }
    
    func cardWidthSize() -> CGFloat{
        (UIScreen.main.bounds.width * 374 / 430)
    }
    
    func cardHeightSize() ->CGFloat{
        (UIScreen.main.bounds.height * 309 / 985)
    }
}

#Preview {
    YourActivityCardView()
}

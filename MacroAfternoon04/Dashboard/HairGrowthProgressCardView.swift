//
//  Hair Growth Progress.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 15/10/24.
//

import SwiftUI

struct HairGrowthProgressCardView: View {
    
    @Binding var showingAddProgressSheet: Bool
    
    var body: some View {
        ZStack(){
            Image("placeholderDashboardYourActivityCard")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 18))
            
            VStack(alignment: .leading){
                Text("Hair Growth Progress")
                    .font(.footnote)
                
                Divider()
                
                HStack{
                    
                    Button{
                        showingAddProgressSheet.toggle()
                    } label: {
                        AddProgressCardView()
                    }
                    
                    Spacer()
                    
                    NavigationLink{
                        RecentProgressView()
                    } label: {
                        LastProgressCardView()
                    }
                    
                    
                }
            }
            .frame(width: cardWidthSize() - 32)
        }
        .frame(width: cardWidthSize(), height: cardHeightSize())
    }
}

func cardWidthSize() -> CGFloat{
    (UIScreen.main.bounds.width * 374 / 430)
}

func cardHeightSize() ->CGFloat{
    (UIScreen.main.bounds.height * 193 / 985)
}

#Preview {
    HairGrowthProgressCardView(showingAddProgressSheet: .constant(false))
}

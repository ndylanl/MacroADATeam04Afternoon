//
//  SuggestionCardView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 01/11/24.
//

import SwiftUI

struct SuggestionCardView: View {
    var body: some View {
        VStack{
            Text("Your hair growth is")
                .font(.title2)
            Text("getting better")
                .font(.system(size: 48))
                .fontWeight(.medium)
            
            HStack{
                VStack(alignment: .leading){
                    Text("• Have more sleep time")
                    Text("• Start more workout")
                        
                }
                
                Spacer()
                
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .frame(width: 58.08, height: 58.08)
                
            }.padding(.horizontal)
            
            
            
        }
    }
}

#Preview {
    SuggestionCardView()
}

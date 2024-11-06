//
//  SuggestionCardView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 01/11/24.
//

import SwiftUI

struct SuggestionCardView: View {
    @StateObject var suggestionViewModel = SuggestionViewModel()
    
    var body: some View {
        VStack {
            Text("Your hair growth is")
                .font(.title2)
            Text("getting better")
                .font(.system(size: 48))
                .fontWeight(.medium)
            
            if !suggestionViewModel.suggestions.isEmpty {
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(suggestionViewModel.suggestions, id: \.self) { suggestion in
                            Text(suggestion)
                        }
                    }
                    
                    Spacer()
                    
                    Image("okay")
                        .resizable()
                        .frame(width: 58.08, height: 58.08)
                }
                .padding(.horizontal)
            }
        }

    }
}

#Preview {
    SuggestionCardView()
}

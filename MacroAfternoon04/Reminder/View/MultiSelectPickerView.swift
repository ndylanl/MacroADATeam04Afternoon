//
//  MultiSelectPickerView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 06/11/24.
//

import SwiftUI

struct MultiSelectPickerView: View {

    @Binding var selectedItems:[RepeatOption]
    
    var body: some View {
        Form {
            List {
                ForEach(RepeatOption.allCases, id: \.self) { option in
                    Button(action: {
                        withAnimation {
                            if self.selectedItems.contains(option) {
                                self.selectedItems.removeAll(where: { $0 == option })
                            } else {
                                self.selectedItems.removeAll(where: { $0 == RepeatOption.never })
                                self.selectedItems.append(option)
                            }
                            if self.selectedItems.contains(RepeatOption.never) {
                                self.selectedItems.removeAll()
                                self.selectedItems.append(RepeatOption.never)
                            }
                        }
                        // Print the current selected items
                        print("Selected items: \(self.selectedItems.map { $0.rawValue })")
                    }) {
                        HStack {
                            Text(option.rawValue)
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "checkmark")
                                .opacity(self.selectedItems.contains(option) ? 1.0 : 0.0)
                                .foregroundColor(Color("PrimaryColor"))
                            
                        }
                    }
                    
                }
            }
        }
    }
}

struct MultiSelectPickerView_Previews: PreviewProvider {
    static var previews: some View {
        // Define the state variables for the preview
        MultiSelectPickerView(selectedItems: .constant([]))
    }
}

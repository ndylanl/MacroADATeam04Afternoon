//
//  Color.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 08/10/24.
//
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255,
            opacity: alpha
        )
    }
}

struct ColorTheme {
    let secondaryColorTheme = Color("SecondaryColor")
    let primaryColorTheme = Color("PrimaryColor")
    let successColorTheme = Color("SuccessColor")
    let warningColorTheme = Color("WarningColor")
    let textColorTheme = Color("TextColor")
    let errorColorTheme = Color("ErrorColor")
    let neutralColorTheme = Color("NeutralColor")
    let backgroundColorTheme = Color("BackgroundColor")
}

//
//  WeekCircleVIew.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 28/10/24.
//

import SwiftUI

struct WeekCircleView: View {
    var weekDate: Date
    
    var body: some View {
        VStack{
            //            Text(formattedDate(weekDate, formatter: weekFormatter))
            Text("Week \(convertToRoman(weekOfMonth(for: weekDate)))")
                .font(.body).bold()
            Text("Report")
                .font(.body)
        }
        .foregroundStyle(Color("PrimaryColor"))
        .frame(width: getCircleSize(), height: getCircleSize())
        .background(.white.opacity(0.8))
        .background(.ultraThinMaterial)
        .clipShape(Circle())
        .shadow(color: Color("PrimaryColor").opacity(0.7), radius: 4, x: 0, y: 3)
//        .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 2)
    }
    
    private func getCircleSize() -> CGFloat {
        UIScreen.main.bounds.width * 106 / 430
    }
    
    private func formattedDate(_ date: Date, formatter: DateFormatter) -> String {
        return formatter.string(from: date)
    }
    
    private var weekFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }
    
    private func weekOfMonth(for date: Date) -> Int {
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
        return weekOfMonth
    }
    
    func convertToRoman(_ number: Int) -> String {
        let romanValues = [
            1000: "M", 900: "CM", 500: "D", 400: "CD",
            100: "C", 90: "XC", 50: "L", 40: "XL",
            10: "X", 9: "IX", 5: "V", 4: "IV", 1: "I"
        ]
        
        var num = number
        var result = ""
        
        for (value, numeral) in romanValues.sorted(by: { $0.key > $1.key }) {
            while num >= value {
                result += numeral
                num -= value
            }
        }
        
        return result
    }
    
}

#Preview {
    WeekCircleView(weekDate: Date())
}

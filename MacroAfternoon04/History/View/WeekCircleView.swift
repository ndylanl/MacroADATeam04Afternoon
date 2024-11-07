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
            Text(formattedDate(weekDate, formatter: weekFormatter))
                .font(.body).bold()
            Text("Report")
                .font(.body)
        }
        .foregroundStyle(Color("PrimaryColor"))
        .frame(width: getCircleSize(), height: getCircleSize())
        .background(.white.opacity(0.5))
        .background(.ultraThinMaterial)
        .clipShape(Circle())
        .shadow(color: Color("PrimaryColor").opacity(0.45), radius: 4, x: 0, y: 4)
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
}

#Preview {
    WeekCircleView(weekDate: Date())
}

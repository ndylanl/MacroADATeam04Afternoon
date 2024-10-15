//
//  DashboardView.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 08/10/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("This is Dashboard")
                    .font(.largeTitle)
                    .padding()
                
                // Button to open ReminderListView
                NavigationLink(destination: ReminderListView()) {
                    Text("Go to Reminders")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                Spacer()
                
                NavigationLink(destination: HealthView()) {
                    Text("Go to Health")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                Spacer()
                
            }             }
    }
}

#Preview {
    DashboardView()
}

//
//  InfoSubtractionSheetView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 29/10/24.
//

import SwiftUI

struct InfoSleepAndMovementSheetView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack (alignment: .leading){
                    Text("How do we get this information?")
                        .font(.title2).bold()
                    
                    Text("Average Sleep Duration")
                        .padding(.top)
                        .font(.title2)
                        .bold()
                    
                    Text("""
                    
                    Our app includes a unique feature that tracks users' average sleep duration and educates them on its correlation with hair growth. This is based on significant research findings from the article titled "Integrative and Mechanistic Approach to the Hair Growth Cycle and Hair Loss", published in the Journal of Clinical Medicine on January 23, 2023. Authored by Nicole Natarelli, Nimrit Gahoonia, and Raja K. Sivamani from institutions such as the University of South Florida and California Northstate University, this study provides comprehensive insights into the complex biological processes that influence hair growth and loss. findings that highlight the vital role of sleep in maintaining healthy hair. Here’s why understanding this connection is essential:
                    
                    1. Sleep Duration and Hair Loss Correlation
                    Key Findings: Research has shown a direct link between insufficient sleep and increased severity of hair loss, particularly in individuals with severe alopecia.
                    Noteworthy Statistic: A study revealed that individuals with severe alopecia who reported sleeping six hours or less had an odds ratio (OR) of 2.16, meaning they were more than twice as likely to experience severe hair loss compared to those with adequate sleep.
                    Implication: Chronic sleep deprivation can exacerbate hair loss due to the physiological stress it places on the body, disrupting the hair growth cycle and follicle health.
                    
                    2. Biological Impact of Insufficient Sleep
                    Hormonal Regulation: Sleep is crucial for hormonal balance, including the regulation of hormones that impact hair growth. Insufficient sleep can disrupt these processes, leading to weakened hair follicles and increased hair loss.
                    Stress Response: Poor sleep increases stress levels, which can negatively affect hair growth. Chronic stress can shift hair follicles into a resting phase prematurely, resulting in more hair shedding and slower regrowth.
                    
                    App Feature: Average Sleep Time Tracking
                    The app tracks users’ average sleep duration and displays it in an easy-to-read format. Users can assess whether their sleep habits align with recommended levels for optimal hair health. The app educates users on how their sleep patterns could be impacting their hair. By identifying patterns of insufficient sleep (less than six hours per night), users are better equipped to make informed lifestyle adjustments to support better hair growth.
                    
                    Practical Recommendations
                    Strive for Adequate Sleep: Ideally, aim for more than six hours of sleep each night to reduce the risk of hair loss severity and promote healthier hair growth.
                    Holistic Benefits: Adequate sleep not only supports hair health but also benefits overall well-being, improving stress management and bodily functions that are crucial for maintaining robust hair follicles.
                    
                    """)
                    
                    Text("Daily Movement")
                        .font(.title2)
                        .bold()
                    
                    Text("""
                    
                    Based on insights from the study titled "Relationship Between Exercise and Severity of Androgenic Alopecia" by Jiang Yumeng et al., published in the Journal of Central South University (Medical Version), here's what users should know:

                    1. Impact of Exercise on Hair Health
                    Androgenic alopecia (AGA) is the most common type of hair loss, often influenced by lifestyle factors. While treatments like medication and transplants are common, physical activity can play a role in managing hair health. Aerobic exercise significantly improves the condition of AGA patients. The study found that patients who engaged in aerobic exercise for over 60 minutes per session were 3.1 times more likely to experience improvement in hair condition compared to those exercising for less than 30 minutes (OR = 3.106, P = 0.009).

                    2. Exercise Types and Effects
                    Aerobic Exercise: Proven to enhance blood circulation, increase oxygen saturation, and improve nutrient transport to hair follicles, which can slow AGA progression and promote hair growth.
                    Duration Matters: Exercise sessions longer than 60 minutes are linked to better outcomes in hair health. Regular, moderate-intensity aerobic exercise can improve the scalp’s blood flow, enhancing hair growth conditions.

                    3. Benefits of Daily Exercise Tracking
                    Stress and Hormonal Balance: Exercise reduces stress and supports hormonal regulation, helping decrease levels of cortisol—a stress hormone that can impact hair health negatively. This reduction can prevent hair follicles from entering a resting phase prematurely.
                    Improved Overall Well-Being: Regular activity improves sleep quality and mental health, both crucial for healthy hair growth.

                    """)
                    
                    Spacer()
                }
                .padding(.vertical, 42)
                
            }
            .frame(width: UIScreen.main.bounds.width * 374 / 430)
            .navigationTitle("Insights")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Done"){
                        isPresented = false
                    }
                }
            }
        }
    }
}


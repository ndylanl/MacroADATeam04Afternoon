//
//  WeeklyReportView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 16/10/24.
//

import SwiftUI
import SwiftData

struct WeeklyReportView: View {
    @StateObject var viewModel: WeeklyReportViewModel
    
    var weekNumber: Int
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text(viewModel.date)
                    .font(.body)
                    .opacity(0.5)
                TabView{
                    ForEach(viewModel.photos, id: \.self) { photo in
                        if let uiImage = UIImage(data: photo) {
                            NavigationLink{
                                ImagePreviewView(image: uiImage)
                            } label: {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: photoSize(), height: photoSize())
                            }
                        } else {
                            Rectangle()
                                .frame(width: photoSize(), height: photoSize())
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: UIScreen.main.bounds.height * 384 / 932)
                
                NavigationLink{
                    RawPhotosView(viewModel: viewModel)
                } label: {
                    Text("See Raw Pictures")
                }
                .padding(.vertical, 16)
                
                Text("Personal Activities")
                    .font(.title2)
                    .bold()
                
                AnyLayout(HStackLayout()){
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("42")
                                .font(.title)
                            Text("hrs")
                                .font(.body)
                        }
                        Text("🌙 Sleep Time")
                            .font(.footnote)
                    }
                    .frame(width: UIScreen.main.bounds.width * 114 / 430, height: UIScreen.main.bounds.height * 110 / 932)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.personalActivities]), startPoint: .top, endPoint: .bottom)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("100")
                                .font(.title)
                            Text("pts")
                                .font(.body)
                        }
                        Text("😀 Stress Level")
                            .font(.footnote)
                    }
                    .frame(width: UIScreen.main.bounds.width * 114 / 430, height: UIScreen.main.bounds.height * 110 / 932)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.personalActivities]), startPoint: .top, endPoint: .bottom)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("100")
                                .font(.title)
                            Text("pts")
                                .font(.body)
                        }
                        Text("🏃 Movement")
                            .font(.footnote)
                    }
                    .frame(width: UIScreen.main.bounds.width * 114 / 430, height: UIScreen.main.bounds.height * 110 / 932)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.personalActivities]), startPoint: .top, endPoint: .bottom)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.bottom, 18)
                
                NavigationLink{
//                    CompareProgressView()
                    EmptyView()
                } label: {
                    Text("Compare Report")
                        .font(.body)
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width * 374 / 430, height: UIScreen.main.bounds.height * 48 / 932)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
            }
            .frame(width: UIScreen.main.bounds.width * 374 / 430, alignment: .leading)
            .navigationTitle("Week \(weekNumber)")
            .navigationBarTitleDisplayMode(.large)
            
            Spacer()
        }
    }
    
    func photoSize() -> CGFloat {
        UIScreen.main.bounds.width * 326 / 430
    }
}

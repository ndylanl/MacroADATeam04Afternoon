////
////  WeeklyReportView.swift
////  MacroAfternoon04
////
////  Created by Alvin Lionel on 16/10/24.
////
//
//import SwiftUI
//import SwiftData
//
//struct WeeklyReportView: View {
//    @StateObject var viewModel: WeeklyReportViewModel
//    @ObservedObject var healthViewModel = HealthViewModel()
//    @State private var isSheetPresented: Bool = false
//    @Environment(\.modelContext) private var modelContext
//    
//    var weekNumber: Int
//    //var reports: [Int]
//    
//    var body: some View {
//        ScrollView{
//            VStack(alignment: .leading){
//                Text(viewModel.date)
//                    .font(.body)
//                    .opacity(0.5)
//                TabView{
//                    ForEach(viewModel.photos, id: \.self) { photo in
//                        
//                        if let uiImage = UIImage(data: photo) {
//                            NavigationLink{
//                                ImagePreviewView(image: uiImage)
//                            } label: {
//                                Image(uiImage: uiImage)
//                                    .resizable()
//                                    .frame(width: photoSize(), height: photoSize())
//                            }
//                        } else {
//                            Rectangle()
//                                .frame(width: photoSize(), height: photoSize())
//                        }
//                    }
//                }
//                .tabViewStyle(.page)
//                .indexViewStyle(.page(backgroundDisplayMode: .always))
//                .frame(height: UIScreen.main.bounds.height * 384 / 932)
//                
//                NavigationLink{
//                    RawPhotosView(viewModel: viewModel)
//                } label: {
//                    Text("See Raw Pictures")
//                }
//                .padding(.vertical, 16)
//                
//                Text("Personal Activities")
//                    .font(.title2)
//                    .bold()
//                
//                AnyLayout(HStackLayout()){
//                    
//                    VStack(alignment: .leading){
//                        HStack{
//                            Text(String(format: "%.1f", healthViewModel.averageSleep))
//                                .font(.title)
//                            Text("hrs")
//                                .font(.body)
//                        }
//                        Text("🌙 Sleep Time")
//                            .font(.footnote)
//                    }
//                    .frame(width: UIScreen.main.bounds.width * 114 / 430, height: UIScreen.main.bounds.height * 110 / 932)
//                    .background(
//                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.personalActivities]), startPoint: .top, endPoint: .bottom)
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                    
//                    Spacer()
//                    
//                    VStack(alignment: .leading){
//                        HStack{
//                            Text(String(format: "%.0f", healthViewModel.averageHeartRate))
//                                .font(.title)
//                            Text("bpm")
//                                .font(.body)
//                        }
//                        Text("💓 Heart Rate")
//                            .font(.footnote)
//                    }
//                    .frame(width: UIScreen.main.bounds.width * 114 / 430, height: UIScreen.main.bounds.height * 110 / 932)
//                    .background(
//                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.personalActivities]), startPoint: .top, endPoint: .bottom)
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                    
//                    Spacer()
//                    
//                    VStack(alignment: .leading){
//                        HStack{
//                            Text(String(format: "%.0f", healthViewModel.averageMovement))
//                                .font(.title)
//                            Text("kcal")
//                                .font(.body)
//                        }
//                        Text("🏃 Movement")
//                            .font(.footnote)
//                    }
//                    .frame(width: UIScreen.main.bounds.width * 114 / 430, height: UIScreen.main.bounds.height * 110 / 932)
//                    .background(
//                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.personalActivities]), startPoint: .top, endPoint: .bottom)
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                }
//                .padding(.bottom, 18)
//                .onAppear {
//                    // Set the date range to calculate the averages
//                    let calendar = Calendar.current
//                    let endDate = Date()
//                    let startDate = calendar.date(byAdding: .day, value: -7, to: endDate)!
//                    
//                    // Panggil fungsi untuk menghitung rata-rata data kesehatan
//                    healthViewModel.calculateAverageSleep(startDate: startDate, endDate: endDate)
//                    healthViewModel.calculateAverageMovement(startDate: startDate, endDate: endDate)
//                    healthViewModel.calculateAverageHeartRate(startDate: startDate, endDate: endDate)
//                }
//                //                .sheet(isPresented: $isPresented) {
//                //                    AddReminderView()
//                Button(action: {
//                    // Set trigger untuk menampilkan modal sheet
//                    isSheetPresented = true
//                }) {
//                    Text("Compare Report")
//                        .font(.body)
//                        .foregroundStyle(.white)
//                        .frame(width: UIScreen.main.bounds.width * 374 / 430, height: UIScreen.main.bounds.height * 48 / 932)
//                        .background(.blue)
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                }
//                .sheet(isPresented: $isSheetPresented) {
//                    // Tampilan modal sheet yang akan ditampilkan
//                    CompareReportsView(viewModel: CompareProgressViewModel(modelContext: modelContext)/*, reports: reports*/)
//                    //CompareProgressView()
//                }
//                
//                
//                
////                NavigationLink{
////                    CompareReportsView()
////                    //                    CompareProgressView()
////                    EmptyView()
////                } label: {
////                    Text("Compare Report")
////                        .font(.body)
////                        .foregroundStyle(.white)
////                        .frame(width: UIScreen.main.bounds.width * 374 / 430, height: UIScreen.main.bounds.height * 48 / 932)
////                        .background(.blue)
////                        .clipShape(RoundedRectangle(cornerRadius: 12))
////                }
//                
//            }
//            .frame(width: UIScreen.main.bounds.width * 374 / 430, alignment: .leading)
//            .navigationTitle("Week \(weekNumber)")
//            .navigationBarTitleDisplayMode(.large)
//            
//            Spacer()
//        }
//    }
//    
//    func photoSize() -> CGFloat {
//        UIScreen.main.bounds.width * 326 / 430
//    }
//}
//
//

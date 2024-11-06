//
//  WeekReportView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 28/10/24.
//

import SwiftUI
import SwiftData

struct WeekReportView: View {
    var date: Date
    @Environment(\.modelContext) private var modelContext
//    @State private var photos: [Data] = []
//    @State private var detections: [[DetectedObject]] = []
    
    @State private var isInfoSheetPresented = false
    
    @State private var isComparePresented: Bool = false
    
    @StateObject var viewModel: WeeklyReportViewModel
    
    let labelColors: [Int: Color] = [
        1: .red,
        2: .purple,
        3: .blue,
        4: .green,
        5: .yellow,
        6: .black
    ]
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text(formattedDate(date, formatter: dateFormatter))
                        .font(.body)
                        .opacity(0.5)
                    
                    Spacer()
                    
                    NavigationLink{
                        RawPhotoView(photos: viewModel.photos)
                    }label: {
                        Text("Raw Photos")
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 374 / 430)
                
                TabView{
                    if viewModel.heatMapArray != [0,0,0,0,0,0,0,0,0,0,0,0]{
                        HeatmapView(data: createDepthData(originalValues: viewModel.heatMapArray, multiple: 4))
                            .clipShape(RoundedRectangle(cornerRadius: 110)) // Apply a rounded rectangle mask with a large corner radius
                    }
                }
                .frame(width:UIScreen.main.bounds.width * 5/6, height: UIScreen.main.bounds.height * 454 / 932)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Topograpy Information")
                        
                        Spacer()
                        
                        Button{
                            isInfoSheetPresented = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.red)
                        Text("Hair")
                    }
                    HStack{
                        Text("●")
                            .foregroundStyle(.yellow)
                        Text("Hair is growing and growing")
                    }
                    HStack{
                        Text("●")
                            .foregroundStyle(.green)
                        Text("Hair is growing")
                    }
                }
                .padding()
                .background(.white)
                .font(.body)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: UIScreen.main.bounds.width * 374 / 430)
                
                TabView{
                    ForEach(Array(viewModel.photos.enumerated()), id: \.element) { index, photoData in
                        if let uiImage = UIImage(data: photoData) {
                            AnnotatedImageView(image: uiImage, detections: viewModel.detections[index + 1], viewModel: viewModel)
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 434 / 932)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Macro Photo Information")
                        
                        Spacer()
                        
                        Button{
                            isInfoSheetPresented = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.red)
                        Text("1 Strand per Follicle")
                    }
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.purple)
                        Text("2 Strand per Follicle")
                    }
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.blue)
                        Text("3 Strand per Follicle")
                    }
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.green)
                        Text("4 Strand per Follicle")
                    }
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.yellow)
                        Text("5 Strand per Follicle")
                    }
                    
                    Text("Average Strands per Follicle: \(viewModel.averageHairPerFollicle)")
                        .padding(.top)
                }
                .padding()
                .background(.white)
                .font(.body)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: UIScreen.main.bounds.width * 374 / 430)
                
                VStack(alignment: .leading){
                    Text("Personal Activities")
                    
                    Divider()
                    
                    HStack{
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("42")
                                    .font(.title)
                                Text("hrs")
                                    .font(.body)
                            }
                            Text("􀇁 Sleep")
                                .font(.footnote)
                        }
                        .frame(width: UIScreen.main.bounds.width * 111 / 430, height: UIScreen.main.bounds.height * 79 / 932)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 0.5)
                        )
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("100")
                                    .font(.title)
                                Text("pts")
                                    .font(.body)
                            }
                            Text("􀙌 Stress")
                                .font(.footnote)
                        }
                        .frame(width: UIScreen.main.bounds.width * 111 / 430, height: UIScreen.main.bounds.height * 79 / 932)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 0.5)
                        )
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("371")
                                    .font(.title)
                                Text("cal")
                                    .font(.body)
                            }
                            Text("􀜟 Movement")
                                .font(.footnote)
                        }
                        .frame(width: UIScreen.main.bounds.width * 111 / 430, height: UIScreen.main.bounds.height * 79 / 932)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 0.5)
                        )
                    }
                    
                }
                .padding()
                .background(.white)
                .font(.body)
                .frame(width: UIScreen.main.bounds.width * 374 / 430)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.vertical)
                
                
                Button{
                    isComparePresented = true
                } label: {
                    Text("Compare Reports")
                        .foregroundStyle(Color("SecondaryColor"))
                }
                .frame(width: UIScreen.main.bounds.width * 374 / 430, height: UIScreen.main.bounds.height * 48 / 932)
                .background(Color("PrimaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            }
            .navigationTitle("Week \(weekOfMonth(for: date))")
        }
        .background(Color(.systemGray6))
        .onAppear {
            viewModel.weekNumber = weekOfMonth(for: date)
            viewModel.fetchData(weekDate: date)
        }
        .sheet(isPresented: $isInfoSheetPresented) {
            InfoSubtractionSheetView(isPresented: $isInfoSheetPresented)
        }
        .sheet(isPresented: $isComparePresented){
            CompareReportSheetView(viewModel: CompareReportViewModel(modelContext: modelContext))
                .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
    
    func photoSize() -> CGFloat {
        UIScreen.main.bounds.width * 374 / 430
    }
    
//    private func fetchPhotos() {
//        let fetchRequest = FetchDescriptor<TrackProgressModel>(
//            predicate: #Predicate { $0.dateTaken == date },
//            sortBy: [SortDescriptor(\.dateTaken, order: .reverse)]
//        )
//        
//        do {
//            let models = try modelContext.fetch(fetchRequest)
//            if let model = models.first {
//                viewModel.photos = model.hairPicture.flatMap { $0.hairPicture }
//                viewModel.detections = model.detections
//            }
//        } catch {
//            print("Failed to fetch photos: \(error)")
//        }
//    }
    
    private func formattedDate(_ date: Date, formatter: DateFormatter) -> String {
        return formatter.string(from: date)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    private func weekOfMonth(for date: Date) -> Int {
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
        return weekOfMonth
    }
}

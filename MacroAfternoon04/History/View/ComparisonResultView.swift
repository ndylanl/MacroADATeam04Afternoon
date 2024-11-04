//
//  ComparisonResultView.swift
//  MacroAfternoon04
//
//  Created by Benedikta Anin on 17/10/24.
//

import SwiftUI

struct ComparisonResultView: View {
    //var viewModel: CompareProgressViewModel // Added viewModel parameter
//    var reportA: Date
//    var reportB: Date
    
    var reportA: Int
    var reportB: Int
    @State var viewModel: ComparisonResultViewModel?
    @State var photosA: [Data] = []
    @State var photosB: [Data] = []
    @Environment(\.modelContext) var modelContext  // Environment context
    // Make sure the initializer is public
    /*init(viewModel: CompareProgressViewModel, reportA: Date, reportB: Date) {
        self.viewModel = viewModel
        self.reportA = reportA
        self.reportB = reportB
    }*/
    init(/*aviewModel: CompareProgressViewModel,*/ reportA: Int, reportB: Int) {
        //self.viewModel = viewModel
        self.reportA = reportA
        self.reportB = reportB
        //self.viewModel = ComparisonResultViewModel(modelContext: modelContext)
        
    }
    
    var body: some View {
        VStack {
            HStack {
                // Display the dates for Report A and B
                VStack {
                    Text("Report A")
                        .font(.title2)
//                    Text(reportA, style: .date)
                    Text("Week \(reportA)")
                        .font(.body)
                        .opacity(0.5)
                    
                    TabView{
                        ForEach(photosA, id: \.self) { photo in
                            
                            if let uiImage = UIImage(data: photo) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: photoWidthSize(), height: photoHeightSize())
                            } else {
                                Rectangle()
                                    .frame(width: photoWidthSize(), height: photoHeightSize())
                            }
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height: UIScreen.main.bounds.height * 384 / 932)
                    
                }
                Spacer()
                VStack {
                    Text("Report B")
                        .font(.title2)
//                    Text(reportB, style: .date)
                    Text("Week \(reportB)")
                        .font(.body)
                        .opacity(0.5)
                    TabView{
                        ForEach(photosB, id: \.self) { photo in
                            
                            if let uiImage = UIImage(data: photo) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: photoWidthSize(), height: photoHeightSize())
                            } else {
                                Rectangle()
                                    .frame(width: photoWidthSize(), height: photoHeightSize())
                            }
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height: UIScreen.main.bounds.height * 384 / 932)
                    
                }
            }
            .padding()
            .onAppear {
                self.viewModel = ComparisonResultViewModel(modelContext: modelContext)
                self.photosA = viewModel?.trackProgressData[reportA - 1].hairPicture.flatMap { $0.hairPicture } ?? []
                self.photosB = viewModel?.trackProgressData[reportB - 1].hairPicture.flatMap { $0.hairPicture } ?? []
            }
            
            
            
            
            
            // Information section
            VStack(alignment: .leading) {
                Text("Information")
                    .font(.headline)
                Text("Hair is growing and growing")
                Text("Number shows how much hair is thickening")
            }
            .padding()
        }
    }
    
    func photoWidthSize() -> CGFloat {
        UIScreen.main.bounds.width * 326 / 430
    }
    
    func photoHeightSize() -> CGFloat {
        UIScreen.main.bounds.height * 290 / 932
    }
}

//struct ComparisonResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComparisonResultView(reportA: Date(), reportB: Date())
//    }
//}

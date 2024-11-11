//
//  MonthReportView.swift
//  MacroAfternoon04
//
//  Created by Alvin Lionel on 29/10/24.
//

import SwiftUI
import SwiftData

struct MonthReportView: View {
    var date: Date
    @Environment(\.modelContext) private var modelContext
    
    @State private var isInfoSheetPresented = false
    
    @StateObject var viewModel: MonthlyReportViewModel
    
    @EnvironmentObject var healthViewModel: HealthViewModel
    
    @State private var renderedImage: UIImage?
    
    var body: some View {
        ScrollView{
            VStack{
                
                TabView{
                    if viewModel.heatMapArray != [0,0,0,0,0,0,0,0,0,0,0,0]{
                        //HeatmapView(data: createDepthData(originalValues: viewModel.heatMapArray, multiple: 4))
                        //.clipShape(RoundedRectangle(cornerRadius: 110)) // Apply a rounded rectangle mask with a large corner radius
                        // BAHAS SAMA TIM MAU PAKE DESIG NUTUPIN ATO GA
                        
                        if let image = renderedImage {
                            Image(uiImage: applyFisheyeEffect(to: image)!)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 454 / 932)
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 354 / 932)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .padding(.bottom, -24)
                .onAppear{
                    let renderer = ImageRenderer(content: HeatmapView(data: createDepthData(originalValues: viewModel.heatMapArray, multiple: 4)))
                    renderedImage = renderer.uiImage
                }
                
                VStack(alignment: .leading){
                    Text("Heat Map Information")
                    
                    Divider()
                    
                    HStack{
                        Text("●")
                            .foregroundStyle(.red)
                        Text("Hair growth can be better")
                    }
                    HStack{
                        Text("●")
                            .foregroundStyle(.green)
                        Text("Hair is stable")
                    }
                    HStack{
                        Text("●")
                            .foregroundStyle(.blue)
                        Text("Hair is growing")
                    }
                    
                }
                .padding()
                .background(.white)
                .font(.body)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: UIScreen.main.bounds.width * 374 / 430)
                
                VStack(alignment: .leading){
                    Text("Last Result & Personal Activities")
                    
                    Divider()
                    
                    VStack(alignment: .center){
                        Text("Your hair growth is")
                            .font(.title2)
                        Text(viewModel.hairGrowthStatus)
                            .font(.largeTitle)
                    }
                    .frame(width: UIScreen.main.bounds.width * 340 / 430)
                    .padding(.vertical)
                    
                    if Int(viewModel.sleepData) ?? 7 <= 6{
                        HStack{
                            Text("·")
                            Text("Have more sleep time")
                        }
                    }
                    
                    if Int(viewModel.movementData) ?? 2001 <= 2000 {
                        HStack{
                            Text("·")
                            Text("Daily workout is recommended")
                        }
                    }
                    
                    HStack{
                        Text("·")
                        Text("Be more consistent with applying serum")
                    }
                    .isHidden(viewModel.applySuggestion, remove: viewModel.applySuggestion)
                    
                    HStack{
                        Text("·")
                        Text("Be more consistent with your appointments")
                    }
                    .isHidden(viewModel.appointmentSuggestion, remove: viewModel.appointmentSuggestion)

                    HStack{
                        Text("·")
                        Text("Be more consistent with consuming medication")
                    }
                    .isHidden(viewModel.consumeSuggestion, remove: viewModel.consumeSuggestion)
                    
                    HStack{
                        Text("·")
                        Text("Be more consistent with your exercises")
                    }
                    .isHidden(viewModel.exerciseSuggestion, remove: viewModel.exerciseSuggestion)

                    HStack{
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text(viewModel.sleepData)
                                    .font(.title)
                                Text("hrs")
                                    .font(.body)
                            }
                            HStack{
                                Image(systemName: "moon.stars.fill")
                                Text("Sleep")
                            }
                            .font(.footnote)
                        }
                        .frame(width: UIScreen.main.bounds.width * 111 / 430, height: UIScreen.main.bounds.height * 79 / 932)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 0.5)
                        )
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text(viewModel.movementData)
                                    .font(.title)
                                Text("cal")
                                    .font(.body)
                            }
                            HStack{
                                Image(systemName: "waveform.path.ecg")
                                Text("Movement")
                            }
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
                .onAppear{
                    viewModel.setPersonalActivity(date: date, healthViewModel: healthViewModel)
                }
                
                
                Button{
                    print("compare button")
                } label: {
                    Text("Compare Reports")
                        .foregroundStyle(Color("SecondaryColor"))
                }
                .frame(width: UIScreen.main.bounds.width * 374 / 430, height: UIScreen.main.bounds.height * 48 / 932)
                .background(Color("PrimaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            }
            .navigationTitle(formattedDate(date, formatter: dateFormatter))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        isInfoSheetPresented = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
        .background(Color(.systemGray6))
        .sheet(isPresented: $isInfoSheetPresented) {
            InfoSubtractionSheetView(isPresented: $isInfoSheetPresented)
        }
    }
    
    private func  photoSize() -> CGFloat {
        UIScreen.main.bounds.width * 374 / 430
    }
    
    
    private func formattedDate(_ date: Date, formatter: DateFormatter) -> String {
        return formatter.string(from: date)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
}

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

func applyFisheyeEffect(to inputImage: UIImage) -> UIImage? {
    let context = CIContext()
    guard let ciImage = CIImage(image: inputImage) else { return nil }
    
    // Create a filter to simulate barrel distortion
    let filter = CIFilter(name: "CIBumpDistortion") // Using bump distortion as an alternative
    filter?.setValue(ciImage, forKey: kCIInputImageKey)
    filter?.setValue(350, forKey: kCIInputRadiusKey) // Radius of the distortion
    filter?.setValue(0.4, forKey: kCIInputScaleKey) // Scale factor for distortion center
    
    // Get the output image
    guard let outputImage = filter?.outputImage,
          let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
    
    return UIImage(cgImage: cgImage)
}

//
//  HeatMap.swift
//  MacroAfternoon04
//
//  Created by Nicholas Dylan Lienardi on 28/10/24.
//

import SwiftUI

// cuman buat testing
let multiple = 4
//let tempArray: [Float] = [1,0,1,0,1,0,1,0,1,0,1,0]

func countNMinusOne(startValue: Int, multiple: Int) -> Int{
    var newValue = startValue
    for _ in 1...multiple {
        newValue = 2 * newValue - 1
    }
    
    return newValue
}

struct HeatmapView: View {
    
    let pixelSize: CGFloat = 4.5
    
    //let data = createDepthData(originalValues: tempArray, multiple: multiple)
    @State var data: [Float]
    
    var body: some View {
        
        VStack(spacing:0){
            ForEach(0..<Int(countNMinusOne(startValue: 6, multiple: multiple)), id:\.self){ row in
                HStack(alignment: .bottom, spacing: 0){
                    ForEach(0..<Int(countNMinusOne(startValue: 5, multiple: multiple)), id:\.self){ column in
                        Rectangle()
                            .fill(self.colorForPixel(row: row, column: column))
                            .frame(width: pixelSize, height: pixelSize)
//                            .blur(radius: 0.1, opaque: true)
                    }
                }
            }
        }
        .onAppear(){
            //print("Data from heatmapView: \(data)")
        }
        
    }
    
    func colorForPixel(row: Int, column: Int) -> Color {
        let index = column + (row * countNMinusOne(startValue: 5, multiple: multiple))
        
        var value = Float(0)
        
        if index <= data.count{
            value = data[index]
        } else {
            value = 1
        }
        
        return Color(UIColor(hue: 2*(CGFloat(value)/3), saturation: 0.95, brightness: 0.8, alpha:1))
    }
}

func createNewData1(row: Int, column: Int, originalValues: [Float]) -> [Float]{
    let new = column * 2 - 1
    let totalCount = row * new
    var data = [Float](repeating: 0.0, count: totalCount)
    var indexOriginalValues = 0
    
    var curCol = 0
    //print(originalValues)
    
    for i in 0..<data.count {
        if curCol % 2 == 0 {
            data[i] = originalValues[indexOriginalValues]
            indexOriginalValues += 1
        } else {
            data[i] = (originalValues[indexOriginalValues - 1] + originalValues[indexOriginalValues]) / 2

        }
        curCol += 1
        
        if curCol == (new) {
            curCol = 0
        }
    }
    //print(data.count)
    return data
    
}

func createNewData2(row: Int, column: Int, originalValues: [Float]) -> [Float]{
    let newOriginalValues = createNewData1(row: row, column: column, originalValues: originalValues)
    let newRow = row * 2 - 1
    let newCol = column * 2 - 1
    let totalCount = newRow * newCol
    var data = [Float](repeating: 0.0, count: totalCount)
    
    var curRow = 0
    var curCol = 0
    
    var indexNewOriginalValues = 0
    var reduced = false

    for i in 0..<data.count {
        if curRow % 2 == 0 {
            if curRow != 0 && reduced{
                indexNewOriginalValues -= newCol
                reduced = false
            }
            data[i] = newOriginalValues[indexNewOriginalValues]
            indexNewOriginalValues += 1
            
        } else {
            
            data[i] = (newOriginalValues[indexNewOriginalValues - newCol] + newOriginalValues[indexNewOriginalValues]) / 2
            indexNewOriginalValues += 1
            reduced = true
            
        }
        
        curCol += 1
        
        if curCol == (newCol) {
            curCol = 0
            curRow += 1
        }
    }
    return data
}

func createDepthData(originalValues: [Float], multiple: Int)-> [Float]{
    var width = 5
    var height = 6
    var tempWidth = width
    var tempHeight = height
    
    print("Multiple: \(multiple)")
    
    for _ in 1...multiple {
        width = 2 * width - 1
    }
    
    for _ in 1...multiple {
        height = 2 * height - 1
    }
    
    print("Width: \(width)")
    print("Height: \(height)")

    let totalDataSize = width * height
    var data = [Float](repeating: 0.0, count: totalDataSize)
    var tempData: [Float] = []
    
    print("----------")
    for i in 1...multiple {
        print("TempHeight: \(tempHeight)")
        print("TempWidth: \(tempWidth)")

        if i == 1{
            tempData = createNewData2(row: tempHeight, column: tempWidth, originalValues: originalValues)
        } else {
            print("Masuk ke sini")
            tempData = createNewData2(row: tempHeight, column: tempWidth, originalValues: tempData)
        }
        
        if tempWidth != width{
            tempWidth = tempWidth * 2 - 1
        }
        
        if tempHeight != height{
            tempHeight = tempHeight * 2 - 1
        }
    }
    data = tempData
    print(data.count)
    print("-----------")
    //print(data)
    
    return data
}

//#Preview {
//    HeatmapView()
//}

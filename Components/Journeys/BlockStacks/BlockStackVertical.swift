//
//  BlockStack.swift
//  Block
//
//  Created by Andrew Campbell on 17/9/2023.
//

import SwiftUI

// View to display all blocks of journey (or combined journeys) in a vertical stack
struct BlockStackVertical: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var settings: Settings
    let blocks: [VisibleBlock]  // array of blocks
    let blockDensity: CGFloat // how many blocks should be on each row of stack
    let target: Int // target of journey
    let themeColor: Color // theme color from settings
    @Binding var showTarget: Bool // toggle to show progress dashboard and horizontal "finish" line

    
    // MARK: - BODY
    var body: some View {
        let numRows = blocks.count/Int(blockDensity) // calculate number of rows required

        Spacer()
        GeometryReader { geometry in
            let blockSize = (geometry.size.width * 0.8)/blockDensity // size of each block (edge of square)
            let spaceSize = (geometry.size.width*0.2)/(blockDensity) // space between each block
            let cornerRadius = blockSize/7
            
            // calculate height of "finish line"
            let rowHeight = blockSize + spaceSize
            let targetRow = ceil(Double(target)/blockDensity)
            let targetHeight = rowHeight*targetRow-(0.5*spaceSize)

            Spacer()
            HStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    ZStack(alignment: .center){

                        // conditionally show "finish line"
                        if(showTarget){
                            Rectangle()
                                .frame(width: geometry.size.width*2, height: 1)
                                .position(y: (geometry.size.height-targetHeight))
                                .foregroundColor(settings.darkMode ? themeColor : .black)
                        }


                        VStack{
                            Spacer()
                            VStack(alignment: .leading, spacing: spaceSize){

                                // conditionally show progress dashboard
                                if(showTarget){
                                    Spacer(minLength: 10).frame(height: 50)
                                    HStack{
                                       Spacer()
                                        JourneyTotalsDisplay(blockCount: blocks.count, target: target, themeColor: themeColor)
                                        Spacer()
                                    }
                                    Spacer(minLength: 50)
                                }


                                //Show all blocks for journey

                                // present remaining blocks in top row
                                HStack(spacing: spaceSize){
                                    ForEach(0..<(blocks.count%Int(blockDensity)), id:\.self) { columnIndex in
                                        let number = (numRows*Int(blockDensity))+columnIndex
                                        let block = blocks[number]
                                        BlockSquare(blockSize: blockSize, blockColor: block.color, cornerRadius: cornerRadius)
                                    } // END FOREACH
                                }

                                // present full rows of blocks below top row
                                ForEach(0..<(numRows), id:\.self) { rowIndex in
                                    HStack(spacing: spaceSize){
                                        ForEach(0..<(Int(blockDensity)), id:\.self) { columnIndex in
                                            let number = (((numRows-rowIndex)-1)*Int(blockDensity))+columnIndex
                                            let block = blocks[number]

                                            BlockSquare(blockSize: blockSize, blockColor: block.color, cornerRadius: cornerRadius)
                                        } // END INNER FOREACH
                                    }
                                } // END FOREACH


                            } // END VSTACK
                        }
                    } // END ZSTACK
                    .frame(minHeight: geometry.size.height)
                } // END SCROLLVIEW
            } // END HSTACK
            Spacer()
        } // END GEOMETRYREADER
        Spacer()
    }
}


//
//  BlockStackHorizontalAllDates.swift
//  Block
//
//  Created by Andrew Campbell on 8/10/2023.
//

import SwiftUI

struct BlockStackHorizontal: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var settings: Settings
    let blocks: [VisibleBlock] // array of blocks
    let blockDensity: CGFloat // blocks per column?
    let showAllDates: Bool // toggle to show either just the dates upon which progress was made, or all dates from when journey started
    let themeColor: Color // themeColor from settings
    let sortedGroupedBlocks: [(String, [VisibleBlock])]// Array of tuples with date string and objects
    var sortedGroupedBlocksAll: [(String, [VisibleBlock])] = []

    init(blocks: [VisibleBlock], blockDensity: CGFloat, showAllDates: Bool, themeColor: Color) {
        self.blocks = blocks
        self.blockDensity = blockDensity
        self.showAllDates = showAllDates
        self.themeColor = themeColor

        // group blocks into their respective timestamp dates
        let groupedBlocks = Dictionary(grouping: blocks) { block in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: block.timestamp)
        }
        
        // sort the block groups by date
        let sortedGroupedBlocks = groupedBlocks.sorted { (entry1, entry2) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date1 = dateFormatter.date(from: entry1.key),
               let date2 = dateFormatter.date(from: entry2.key) {
                return date1 < date2
            }
            return false
        }


        // iterate through all dates in range
        // if no blocks on a specific date add an empty array, otherwise add the block array for that date
        var allDateBlocks: [(String, [VisibleBlock])] = []
        var dateRange : [String] = []

        if(sortedGroupedBlocks.count>0){
            dateRange = datesInRange(startDate: sortedGroupedBlocks.first!.0, endDate: sortedGroupedBlocks.last!.0)
        }

        var presentBlocksIndex = 0
        var dayIndex = 0
        for date in dateRange{
            if(date == sortedGroupedBlocks[presentBlocksIndex].0){
                allDateBlocks.append(sortedGroupedBlocks[presentBlocksIndex])
                presentBlocksIndex+=1
            }else{
                allDateBlocks.append((date, []))
            }
            dayIndex += 1
        }

        self.sortedGroupedBlocksAll = allDateBlocks
        self.sortedGroupedBlocks = sortedGroupedBlocks
    }


    // MARK: - FUNCTIONS

    // get the day numbers from a String containing the date in the format yyyy-mm-dd
    func extractDateComponent(dateString: String, index: Int) -> String {
        let dateComponents = dateString.split(separator: "-")
        return String(dateComponents[index])
    }

    // automatically scroll to the end of the horizontal scroll view
    func scrollToEnd(proxy: ScrollViewProxy){
        if (blocks.count > 0){
            if(showAllDates){
                proxy.scrollTo(sortedGroupedBlocksAll[sortedGroupedBlocksAll.count-1].0)
                print("scroll to \(sortedGroupedBlocksAll[sortedGroupedBlocksAll.count-1].0)")
            }else{
                proxy.scrollTo(sortedGroupedBlocks[sortedGroupedBlocks.count-1].0)
                print("scroll to \(sortedGroupedBlocks[sortedGroupedBlocks.count-1].0)")
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            let blockSize = (geometry.size.width * 0.9)/blockDensity // the edge length of t blocks
            let spaceSize = (geometry.size.width*0.3)/(blockDensity) // space between blocks in same vertical stack
            let colHeight = Int((geometry.size.height*0.7)/blockSize) // max number of blocks in column
            let dayStackSpacing = blockSize/2 // spacing between vertical stacks containing blocks for single day
            let cornerRadius = blockSize/7

            VStack{
                Spacer()
                ScrollViewReader{proxy in
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(alignment: .bottom, spacing: blockSize/2) { // Align stacks at the bottom

                            // iterate over each dictionary pair representing a single date
                            ForEach(showAllDates ? sortedGroupedBlocksAll : sortedGroupedBlocks, id: \.0) { groupBlocks in
                                VStack(alignment: .leading, spacing: dayStackSpacing){ // each VStack contains the blocks on a single date
                                    HStack(alignment: .bottom, spacing: spaceSize){ // HStack requires as come dates contains blocks for multiple columns

                                        let numCols = groupBlocks.1.count/colHeight // calc number of cols for single date

                                        // if multiple columns required, create the visualisations of the "full"columns
                                        ForEach(0..<numCols, id: \.self){colNum in
                                            VStack(alignment: .leading, spacing: spaceSize) {
                                                ForEach(0..<colHeight, id: \.self) { rowNum in
                                                    
                                                    let number = (colNum*colHeight)+rowNum
                                                    let block = groupBlocks.1[number]
                                                    BlockSquare(blockSize: blockSize, blockColor: block.color, cornerRadius: cornerRadius)
                                                    
                                                }
                                            }
                                        }

                                        // create the column of the remaining blocks not in a "full column"
                                        VStack(alignment: .leading, spacing: spaceSize) {
                                            ForEach(0..<(groupBlocks.1.count%colHeight), id: \.self) { rowNum in
                                                let number = (numCols*numCols)+rowNum
                                                let block = groupBlocks.1[number]
                                                BlockSquare(blockSize: blockSize, blockColor: block.color, cornerRadius: cornerRadius)
                                            }
                                        }
                                        .id(groupBlocks.0) // id used for auto scrolling purposes
                                    }// HSTACK END

                                    // display the and month
                                    VStack(alignment: .center){
                                        Text(extractDateComponent(dateString: groupBlocks.0, index: 2))
                                        Text("-")
                                        Text(extractDateComponent(dateString: groupBlocks.0, index: 1))
                                    }
//                                    .frame(width: blockSize)
                                    .fontWeight(.bold)
                                    .foregroundColor(settings.darkMode ? themeColor : .black)


                                }// VSTACK END
                            } // FOREACH END
                        }// HSTACK END
                    }// SCROLLVIEW END
                    .onAppear {
                        scrollToEnd(proxy: proxy)
                    }
                    .onChange(of: blocks.count) { _ in
                        scrollToEnd(proxy: proxy)
                    }
                    .onChange(of: showAllDates) { _ in
                        scrollToEnd(proxy: proxy)
                    }
                }// SCROLLVIEW READER END
            }// VSTACK END
            .frame(maxHeight: geometry.size.height * 1)
        }// GEOMETRY END
    }// VIEW END

}


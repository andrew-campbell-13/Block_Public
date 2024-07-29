//
//  FullJourneyStack.swift
//  Block
//
//  Created by Andrew Campbell on 3/10/2023.
//

import SwiftUI

struct CombinedJourneyView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @StateObject private var settings = Settings()
    @FetchRequest(sortDescriptors: []) private var journeys: FetchedResults<Journey>
    @State var showHorizontalView: Bool = false;
    @State var showMenu: Bool = false
    @State private var showAllDates = false
    @State private var showTarget = false
    @State private var blockDensityIndex = 0
    private let densities: [CGFloat] = [20, 15, 10]

    // MARK: - PROPERTIES
    
    // return day of date
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd" // Define your desired date format here
        return formatter
    }()

    
    // MARK: - FUNCTIONS
    var mergedList: [Block] {
        // Use flatMap to combine all the lists into one array
        let combinedList = journeys.flatMap { $0.blockArray }
        
        print(journeys.count)
        
        // Sort the combined list by date
        return combinedList.sorted(by: { $0.timestamp! < $1.timestamp! })
    }
    
    
    var mergeBlocks: [VisibleBlock] {
        // Use flatMap to combine all the lists into one array
        var combinedList: [VisibleBlock] = []
        
        for journey in journeys {
            for block in journey.blockArray{
                combinedList.append(VisibleBlock(id: block.id!, timestamp: block.timestamp!, color: getColor(colorString: journey.color!)))
            }
        }
        
        print(journeys.count)
        
        // Sort the combined list by date
        return combinedList.sorted(by: { $0.timestamp < $1.timestamp })
    }
    
    func toggleMenu(){
        showMenu = !showMenu
    }

    
    func exitView() {
        dismiss()
    }

    // MARK: - BODY
    var body: some View {
        let themeColor = getColor(colorString: settings.mainThemeColor)
        
        VStack(alignment: .center){
            // journey header with title of journey and buttons to exit to main menu or change the display of the journey
            JourneyHeader(exitView: exitView, toggleMenu: toggleMenu, themeColor: themeColor, title: "Combined")

            // display options
            if(showMenu){
                CombinedJourneyDisplayOptions(themeColor: themeColor, showHorizontalView: $showHorizontalView,   showAllDates: $showAllDates, blockDensityIndex: $blockDensityIndex)
            }
            Spacer()

            // show combined progress of all journeys either in stack or columns for each date
            HStack{
                Spacer()
                VStack(alignment: .center){
                    if (showHorizontalView){
                        BlockStackHorizontal(blocks: mergeBlocks, blockDensity: densities[blockDensityIndex], showAllDates: showAllDates, themeColor: themeColor)
                    }else{
                        BlockStackVertical(blocks: mergeBlocks, blockDensity: densities[blockDensityIndex], target: 10, themeColor: themeColor, showTarget: $showTarget)
                    }     
                }
                Spacer()
            }
        }
        .background(getColor(colorString: settings.darkMode ? "black" : "beige" ))
        .navigationBarHidden(true)
        
    }
    
}


// visually represents each journey block
struct VisibleBlock: Identifiable {
    let id: UUID
    let timestamp: Date
    let color: Color
}


// MARK: - PREVIEW
struct CombinedJourneyView_Previews: PreviewProvider {
    @FetchRequest(sortDescriptors: []) private var journeys: FetchedResults<Journey>

    static var previews: some View {
        CombinedJourneyView()
    }
}

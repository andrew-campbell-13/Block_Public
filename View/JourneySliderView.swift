//
//  JourneySliderView.swift
//  Block
//
//  Created by Andrew Campbell on 20/9/2023.
//

import SwiftUI
import CoreData

struct JourneySliderView: View {
    // MARK: PROPERTIES
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var settings: Settings

    // return non-completed journeys from core data
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "completed != %@", NSNumber(value: true))) private var journeys: FetchedResults<Journey>
    @State private var journeyIndex = 0 // index to change journey showing on screen
    @State var showHorizontalView: Bool = false; // toggle stack and horiztonal view
    @State var showDeleteOption: Bool = false; // toggle showing option to delete journey
    @State var showMenu: Bool = false // show menu to alter view
    @State var showAllDates: Bool = false // toggle showing dates in which no progress was made
    @State var showTarget: Bool = false // show target line and progress dashboard in stack view
    @State var blockDensityIndex: Int  = 0 // index to determine size of block, and therfore density
    @State var densities: [CGFloat] = [20, 15, 10]  // blocks sizes
    @State var showAchievedTargetPopUp = false // show pop up if journey progress == journey target
    
    // MARK: - FUNCTIONS

    // delete journey from core data
    private func deleteJourney() {


        showDeleteOption = false
        moc.delete(journeys[journeyIndex])

        if(journeys.count>1){
            journeyIndex = (journeyIndex+1)%(journeys.count-1)
        }else{
            journeyIndex = 0
        }
        
        try? moc.save()
    }

    // hide pop up
    private func hideAchievedTargetPopUp(){
        showAchievedTargetPopUp = false
    }

    // add block to core data - belongs to journey
    private func addBlock(){
        print("add block")
        let block = Block(context: moc)
        block.id = UUID()
        block.timestamp = Date()
        block.origin = journeys[journeyIndex]
        do {
            try moc.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    // set journey as completed -> will be moved to completed journeys view
    private func archiveCompletedJourney(){
        journeys[journeyIndex].completed = true

        // set current journey on screen as the next journey
        if(journeys.count>1){
            journeyIndex = (journeyIndex+1)%(journeys.count-1)
        }else{
            journeyIndex = 0
        }

        do {
            try moc.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    // go to next active journey
    private func nextJourney() {
        journeyIndex = (journeyIndex+1)%(journeys.count)
    }

    // go to previous active journey
    private func previousJourney() {
        let result = journeyIndex-1 % (journeys.count)
        if(result >= 0) { journeyIndex=result} else{ journeyIndex = result + journeys.count}
    }


    // create the visual representations on the blocks - VisibleBlock
    var createVisBlocks: [VisibleBlock] {
        var combinedList: [VisibleBlock] = []
        for block in journeys[journeyIndex].blockArray{
            combinedList.append(VisibleBlock(id: block.id!, timestamp: block.timestamp!, color: getColor(colorString: journeys[journeyIndex].color!)))
        }
        return combinedList
    }

    func toggleMenu(){
        showMenu = !showMenu
    }
    
    func exitView() {
        dismiss()
    }
    
    // MARK: - BODY
    var body: some View {

        if (journeys.count==0){
            EmptyView(message: "No Active Journeys")
        }else{
            let themeColor = getColor(colorString: journeys[journeyIndex].color ?? "Blue")
            let symbol = getCategorySymbol(inputString: journeys[journeyIndex].category ?? "undefined")
            let symbol_filled = symbol + ".fill"
            let showArchiveJourney = journeys[journeyIndex].blockArray.count>=journeys[journeyIndex].target
            
            ZStack{
                if (journeys[journeyIndex].blockArray.count == journeys[journeyIndex].target){
                    CompletedJourneyPopUp()
                }
                VStack(alignment: .center){

                    // journey header with title of journey and buttons to exit to main menu or change the display of the journey
                    JourneyHeader(exitView: exitView, toggleMenu: toggleMenu, themeColor: themeColor, title: journeys[journeyIndex].title ?? "undefined")
                    if(showMenu){
                        JourneyDisplayOptions(themeColor: themeColor, showHorizontalView: $showHorizontalView,   showAllDates: $showAllDates, showTarget: $showTarget, blockDensityIndex: $blockDensityIndex, showDeleteOption: $showDeleteOption, showArchiveJourney: showArchiveJourney, archiveJourney: archiveCompletedJourney, deleteJourney: deleteJourney)
                    }
                    Spacer()

                    // main part of view between header and control buttons where either stack or horizontal view of blocks is displayed
                    HStack(){
                        Spacer()
                        if (showHorizontalView){
                            BlockStackHorizontal(blocks: createVisBlocks, blockDensity: densities[blockDensityIndex], showAllDates: showAllDates, themeColor: themeColor)
                        }else{
                            BlockStackVertical(blocks: createVisBlocks, blockDensity: densities[blockDensityIndex], target:  Int(journeys[journeyIndex].target), themeColor: themeColor, showTarget: $showTarget)
                        }
                        Spacer()
                    }

                    // control buttons to change between journeys or add block to journey
                    Spacer()
                    HStack{
                        ControlButton(action: previousJourney, imageString: "arrow.left", color: themeColor)
                        IncrementProgressButton(action: addBlock, imageString_default: symbol, imageString_pressed: symbol_filled, color: themeColor)
                        ControlButton(action: nextJourney, imageString: "arrow.right", color: themeColor)
                        
                    }
                } // END OUTER VSTACK
            } // END ZSTACK
            .background(getColor(colorString: settings.darkMode ? "black" : "beige" ))
            .navigationBarHidden(true)
        }
        
    }
    
    
}

struct JourneySliderView_Previews: PreviewProvider {
    static var previews: some View {
        JourneySliderView()
    }
}

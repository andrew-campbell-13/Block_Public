//
//  DisplayOptions.swift
//  Block
//
//  Created by Andrew Campbell on 13/10/2023.
//

import SwiftUI

struct JourneyDisplayOptions: View {
    // MARK: - PROPERTIES
    var themeColor: Color
    @Binding var showHorizontalView: Bool // show view where progress is shown in date columns rather than a stack
    @Binding var showAllDates: Bool // show all dates even if no blocks recorded on given date
    @Binding var showTarget: Bool // in stack view, show target "finish" line and progress dashboard
    @Binding var blockDensityIndex: Int // determined by the size of the blocks
    @Binding var showDeleteOption: Bool // show option to delete journey
    var showArchiveJourney: Bool // show option to archive journey is progress >= target
    var archiveJourney: () -> Void // function to archive journey
    var deleteJourney: () -> Void // function to delete journey

    // MARK: - FUNCTIONS
    func toggleView(){
        showHorizontalView = !showHorizontalView
    }
    
    func toggleBlockSize(){
        blockDensityIndex=(blockDensityIndex+1)%3
    }
    
    func toggleShowAllDates(){
        showAllDates = !showAllDates
    }
    
    func toggleShowTarget(){
        showTarget = !showTarget
    }
    
    func toggleShowDeleteOptons(){
        showDeleteOption = !showDeleteOption
    }

    // MARK: - BODY
    var body: some View {
        VStack{
            HStack{
                Group{
                    Spacer(minLength: 10)
                    ViewModifierButton(action: toggleView, displayString: showHorizontalView ? "square.grid.3x2.fill": "chart.bar.fill", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                    Spacer(minLength: 10)
                    ViewModifierButton(action: toggleBlockSize, displayString: "arrow.up.square", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                    Spacer(minLength: 10)
                }
                if(showHorizontalView){
                    ViewModifierButton(action: toggleShowAllDates, displayString: showAllDates ? "arrow.down.right.and.arrow.up.left": "arrow.up.left.and.arrow.down.right" , color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                        .font(.system(size: 30))
                    Spacer(minLength: 10)
                }else{
                    ViewModifierButton(action: toggleShowTarget, displayString: "map", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                    Spacer(minLength: 10)
                }
                Group{
                    if(showArchiveJourney){
                        ViewModifierButton(action: archiveJourney, displayString: "bolt", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                        Spacer()
                    }
                    
                    ViewModifierButton(action: toggleShowDeleteOptons, displayString: "minus.square", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                    Spacer()
                }
            }
            if(showDeleteOption){
                HStack{
                    Text("Delete journey?")
                    ViewModifierButton(action: deleteJourney, displayString: "Y", color: themeColor, fontSize: 30, isImage: false, isDisabled: false)
                    ViewModifierButton(action: toggleShowDeleteOptons, displayString: "N", color: themeColor, fontSize: 30, isImage: false, isDisabled: false)
                }
            }
            
        }
        .font(.system(size: 30))
        .fontWeight(.bold)
        .foregroundColor(themeColor)
        .padding(.top, 1)
        .cornerRadius(10)
    }
}


//
//  CombinedJourneyDisplayOptions.swift
//  Block
//
//  Created by Andrew Campbell on 14/12/2023.
//

import SwiftUI

struct CombinedJourneyDisplayOptions: View {
    // MARK: - PROPERTIES
    var themeColor: Color
    @Binding var showHorizontalView: Bool // show view where progress is shown in date columns rather than a stack
    @Binding var showAllDates: Bool // show all dates even if no blocks recorded on given date
    @Binding var blockDensityIndex: Int // determined by the size of the blocks

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

    // MARK: - BODY
    var body: some View {
        VStack{
            HStack{
                Spacer(minLength: 10)
                ViewModifierButton(action: toggleView, displayString: showHorizontalView ? "square.grid.3x2.fill": "chart.bar.fill", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                Spacer(minLength: 10)
                ViewModifierButton(action: toggleBlockSize, displayString: "arrow.up.square", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                Spacer(minLength: 10)
                if(showHorizontalView){
                    ViewModifierButton(action: toggleShowAllDates, displayString: showAllDates ? "arrow.down.right.and.arrow.up.left": "arrow.up.left.and.arrow.down.right" , color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                        .font(.system(size: 30))
                    Spacer(minLength: 10)
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

//struct CombinedJourneyDisplayOptions_Previews: PreviewProvider {
//    static var previews: some View {
//        CombinedJourneyDisplayOptions()
//    }
//}

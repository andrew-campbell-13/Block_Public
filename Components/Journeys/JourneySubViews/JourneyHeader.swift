//
//  JourneyHeader.swift
//  Block
//
//  Created by Andrew Campbell on 14/12/2023.
//

import SwiftUI

struct JourneyHeader: View {
    // MARK: - PROPERTIES
    var exitView: () -> Void // function to exit to main menu
    var toggleMenu: () -> Void // function to show/hide display menu
    let themeColor: Color
    let title: String

    // MARK: - BODY
    var body: some View {
        HStack(){
            Spacer().frame(width: 7)
            ViewModifierButton(action: exitView, displayString: "house", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
            Spacer()
            JourneyTitle(title: title, color: themeColor)
            Spacer()
            ViewModifierButton(action: toggleMenu, displayString: "slider.horizontal.3", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
            Spacer().frame(width: 7)
        }
        .font(.system(size: 30))
        .fontWeight(.bold)
        .foregroundColor(themeColor)
        .padding(.top, 10)
    }
}



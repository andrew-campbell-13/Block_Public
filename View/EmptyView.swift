//
//  SwiftUIView.swift
//  Block
//
//  Created by Andrew Campbell on 9/12/2023.
//

import SwiftUI

// view displayed when there are no components to display in the view - either journeys or completed journeys
struct EmptyView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var settings: Settings
    @Environment(\.dismiss) var dismiss
    let message: String
    
    // MARK: - FUNCTIONS
    func exitView() {
        dismiss()
    }
    
    // MARK: - BODY
    var body: some View {
        let themeColor = getColor(colorString: settings.mainThemeColor)
        
        VStack{
            Spacer()
            HStack{
                Spacer()
                Text(message)
                Spacer()
            }
            HStack{
                Spacer()
                ViewModifierButton(action: exitView, displayString: "house", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                Spacer()
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .foregroundColor(settings.darkMode ? themeColor : .black)
        .background(getColor(colorString: settings.darkMode ? "black" : "beige" ))
    }
}

// MARK: - PREVIEW
struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(message: "blank screen")
    }
}

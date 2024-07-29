//
//  ViewNavButton.swift
//  Block
//
//  Created by Andrew Campbell on 7/10/2023.
//

import SwiftUI

// Component for each button on the home page
struct ViewNavButton: View {
    // MARK: - PROPERTIES
    @StateObject private var settings = Settings()
    var buttonText: String

    // MARK: - BODY
    var body: some View {
        if (settings.darkMode){
            Text(buttonText)
                .padding(15)
                .font(.system(size: 20))
                .frame(width: 300)
                .foregroundColor(getColor(colorString: settings.mainThemeColor))
                .border(getColor(colorString: settings.mainThemeColor), width: 5).cornerRadius(10)
        }else{
            ZStack{
                RoundedRectangle(cornerRadius: 10 )
                    .frame(width: 300, height: 50)
                    .foregroundColor(.black)
                RoundedRectangle(cornerRadius: 8 )
                    .frame(width: 296, height: 46)
                    .foregroundColor(getColor(colorString: settings.mainThemeColor))
                Text(buttonText).foregroundColor(.black) .font(.system(size: 20))        
            }
        }
    }
}


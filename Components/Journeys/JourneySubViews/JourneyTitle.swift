//
//  JourneyTitle.swift
//  Block
//
//  Created by Andrew Campbell on 13/10/2023.
//

import SwiftUI

// The title displayed at the top of the Journeys and Combined Journey View
struct JourneyTitle: View {
    // MARK: - PROPERTIES
    @StateObject private var settings = Settings()
    var title: String
    var color: Color

    // MARK: - BODY
    var body: some View {
        if(settings.darkMode){
            Text(title)
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(color)
                .padding(.top, 10)
                .multilineTextAlignment(.center)
        }else{
            Text(title)
                .font(.system(size: 40))
                .foregroundColor(.black)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 3)
                .padding(.bottom, 3)
                .multilineTextAlignment(.center)
        }
    }
}



//
//  CompletedJourneyPopUp.swift
//  Block
//
//  Created by Andrew Campbell on 14/12/2023.
//

import SwiftUI

struct CompletedJourneyPopUp: View {
    // MARK: - BODY
    var body: some View {
        VStack{
            Text("Congratulations!")
            Text("You have now completed your journey. Select the ligntening icon in the menu bar to add this journey to the completed journeys page. Otherwise, keep hammering!")
        }
    }
}

// MARK: - PROPERTIES
struct CompletedJourneyPopUp_Previews: PreviewProvider {
    static var previews: some View {
        CompletedJourneyPopUp()
    }
}

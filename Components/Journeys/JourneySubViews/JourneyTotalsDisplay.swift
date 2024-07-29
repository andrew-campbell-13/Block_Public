//
//  TotalsDisplay.swift
//  Block
//
//  Created by Andrew Campbell on 14/10/2023.
//

import SwiftUI

// The View displayed when the user is in the standard stack view of the journey and wants to see a progress dashboard
struct JourneyTotalsDisplay: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var settings: Settings
    let blockCount: Int
    let target: Int
    let themeColor: Color

    // percentage of blocks in journey compared to journey target
    var completePercentage : Int {
        if(blockCount > 0){
            return Int((Double(blockCount)/Double(target))*100)
        }else{
            return 0
        }
    }

    // MARK: - BODY
    var body: some View {
        ZStack{
            VStack{
                Text("\(blockCount) | \(target)")
                Spacer()
                        .frame(height: 10)
                Text("\(completePercentage)%")
            }.padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 2)
                )
            .foregroundColor(settings.darkMode ? themeColor : .black)
        }
    }
}

struct JourneyTotalsDisplay_Previews: PreviewProvider {
    @EnvironmentObject var settings: Settings
    static var previews: some View {
        JourneyTotalsDisplay(blockCount: 14, target: 50, themeColor: .red)
    }
}

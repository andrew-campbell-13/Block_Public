//
//  JourneyLine.swift
//  Block
//
//  Created by Andrew Campbell on 6/12/2023.
//

import SwiftUI


// Journey Line represents each completed journey in the Complete Journey View
struct JourneyLine: View {
    
    // MARK: - PROPERTIES
    @StateObject private var settings = Settings()
    @Environment(\.managedObjectContext) var moc
    @State var displayDropDown: Bool = false;
    let journey: Journey
    
    // MARK: - FUNCTIONS

    // return journey to active journeys and remove from completed journeys
    private func reactivateJourney(){
        print("reactivate journey")
        journey.completed = false
        do {
            try moc.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    // MARK: - BODY
    var body: some View {
        let symbol = getCategorySymbol(inputString: journey.category ?? "undefined")
        let themeColor = getColor(colorString: settings.mainThemeColor)
        
        HStack{
            Spacer().frame(width: 7)
            HStack{
                Spacer().frame(width: 7)
                Image(systemName: symbol)
                    .frame(width: 50)
                    .font(.system(size: 30))
                Text(journey.title ?? "undefined")
                    .padding(20)
                Spacer()
                if(displayDropDown){
                    ViewModifierButton(action: reactivateJourney, displayString: "bolt", color: themeColor, fontSize: 20, isImage: true, isDisabled: false)
                }else{
                    Text("\(journey.blockArray.count)  |")
                    Text("\(journey.target)")
                }
                Spacer().frame(width: 7)
            } // END - INNER HSTACK
            .font(.system(size: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 2)
            )
            Spacer().frame(width: 7)
        } // END - OUTER HSTACK
        .onTapGesture {
            displayDropDown = !displayDropDown
        }
    }
}



//
//struct JourneyLine_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack(alignment: .center){
//            JourneyLine()
//
//        }
//    }
//}

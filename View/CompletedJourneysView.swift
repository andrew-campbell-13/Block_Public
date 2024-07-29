//
//  CompletedJourneysView.swift
//  Block
//
//  Created by Andrew Campbell on 5/12/2023.
//

import SwiftUI

// view showing the completed journeys
struct CompletedJourneysView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @StateObject private var settings = Settings()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "completed == %@", NSNumber(value: true))) private var completedJourneys: FetchedResults<Journey>
    
    // MARK: - FUNCTIONS
    func exitView() {
        dismiss()
    }
    
    // MARK: - BODY
    var body: some View {
        if (completedJourneys.count==0){
            EmptyView(message: "No Completed Journeys")
        }else{
            let themeColor = getColor(colorString: settings.mainThemeColor)

            VStack(alignment: .center){
                // title
                Text("Completed Journeys")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(settings.darkMode ? themeColor : .black)
                    .padding(10)

                // show all completed journeys
                ForEach(completedJourneys, id: \.self) {journey in
                    JourneyLine(journey: journey)
                }.padding(5)
                Spacer()

                // exit to main menu button
                HStack{
                    Spacer()
                    ViewModifierButton(action: exitView, displayString: "house", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                    Spacer()
                }
                .listRowBackground(settings.darkMode ? Color.black.edgesIgnoringSafeArea(.all) :  Color("Beige").edgesIgnoringSafeArea(.all))
                Spacer()
            } // END VSTACK
            .background(getColor(colorString: settings.darkMode ? "black" : "beige" ))
            .foregroundColor(settings.darkMode ? themeColor : .black)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - PREVIEW
struct CompletedJourneysView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedJourneysView()
    }
}

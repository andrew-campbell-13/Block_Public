//
//  Menu.swift
//  Block
//
//  Created by Andrew Campbell on 20/9/2023.
//

import SwiftUI

// Home page of App
struct HomeView: View {
    // MARK: - PROPERTIES
    @StateObject private var dataController = DataController()
    @StateObject private var settings = Settings()

    // MARK: - BODY
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                ZStack{
                    if (!settings.darkMode) {RoundedRectangle(cornerRadius: 20).foregroundColor(.black).frame(width: 300, height: 300)}
                    RoundedRectangle(cornerRadius: 18).foregroundColor(getColor(colorString: settings.mainThemeColor)).frame(width: 296, height: 296)
                    Text("Block")
                        .padding(15)
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                }
                Spacer()
                NavigationLink(destination:  JourneySliderView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)) {
                        ViewNavButton(buttonText: "Journeys")
                        
                    }
                NavigationLink(destination:  CombinedJourneyView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)) {
                        
                        ViewNavButton(buttonText: "Combined Journey")
                    }
                NavigationLink(destination:  AddJourneyView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)) {
                        ViewNavButton(buttonText: "Add Journey")
                    }
      
                NavigationLink(destination:  CompletedJourneysView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)) {
                        ViewNavButton(buttonText: "Completed Journeys")
                        
                    }
                NavigationLink(destination:  SettingsView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)) {
                        ViewNavButton(buttonText: "Settings")
                        
                    }
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(getColor(colorString: settings.darkMode ? "black" : "beige" ))
        }.environmentObject(settings)
    }
}

// MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Settings())
    }
}

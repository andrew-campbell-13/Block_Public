//
//  AddJourneyView.swift
//  Block
//
//  Created by Andrew Campbell on 16/9/2023.
//

import SwiftUI

// View containing form to add journey
struct AddJourneyView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: Settings
    @State private var title = ""
    @State private var target = ""
    @State private var category = "fitness" // default category set
    @State private var color = "blue" // default color

    // journey options for given fields
    let colors = ["blue", "orange", "yellow", "green", "pink", "purple"]
    let categories = ["fitness", "work", "study", "soul", "hobby", "cooking"]

    var targetIsNumber: Bool {
        Int(target) != nil
    }

    var targetIsValid: Bool{
        targetIsNumber && Int(target)! > 0 && Int(target)! < 999999
    }

    var titleIsLetters: Bool{
        let letterRegex = "^[a-zA-Z ]+$"
        return NSPredicate(format: "SELF MATCHES %@", letterRegex).evaluate(with: title)
    }

    var titleIsValid: Bool {
        titleIsLetters && title.count > 0 && title.count < 25
    }


    var formIsValid: Bool {
        titleIsValid && targetIsValid
    }
    
    // MARK: - FUNCTIONS
    func exitView() {
        print("dismissing")
        dismiss()
    }

    // add journey and store in core data
    func addJourney() {
        print("running add journey")
        let journey = Journey(context: moc)
        journey.id = UUID()
        journey.title = title
        journey.category = category
        journey.target = Int32(target) ?? 0
        journey.color = color
        journey.progress = 0
        journey.completed = false
        print("adding category: " + category)
        try? moc.save()
        dismiss()
    }
    
    // MARK: - BODY
    var body: some View {
        let themeColor = getColor(colorString: settings.mainThemeColor)
        
        VStack(alignment: .center){
            Spacer()
            Text("Add Journey")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(settings.darkMode ? themeColor : .black)
            Form{
                Section{
                    // enter journey title
                    TextField("Title of Journey", text: $title, prompt: Text("Enter Title")
                        .foregroundColor(settings.darkMode ? themeColor : .black))

                    // enter journey target
                    TextField("Target of Journey", text: $target, prompt: Text("Enter Target")
                        .foregroundColor(settings.darkMode ? themeColor : .black))

                    // select journey category from options
                    Picker("Category", selection: $category){
                        ForEach(categories, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)

                    // select journey colour from options
                    Picker("Block Colour", selection: $color){
                        ForEach(colors, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)

                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 2)
                )
                .listRowBackground(settings.darkMode ? Color.black.edgesIgnoringSafeArea(.all) :  Color("Beige").edgesIgnoringSafeArea(.all))
                .accentColor(settings.darkMode ? themeColor : .black)
                .listRowSeparator(.hidden)
                
                HStack{
                    Spacer()
                    ViewModifierButton(action: addJourney, displayString: "plus", color: themeColor, fontSize: 30, isImage: true, isDisabled: !formIsValid)
                    Spacer()
                    ViewModifierButton(action: exitView, displayString: "house", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                    Spacer()
                }
                .listRowBackground(settings.darkMode ? Color.black.edgesIgnoringSafeArea(.all) :  Color("Beige").edgesIgnoringSafeArea(.all))
            }//: FORM END
        }//: VSTACK END
        .navigationBarHidden(true)
        .scrollContentBackground(.hidden)
        .background(settings.darkMode ? Color.black.edgesIgnoringSafeArea(.all) :  Color("Beige").edgesIgnoringSafeArea(.all))
        .foregroundColor(settings.darkMode ? themeColor : .black)
    }
}

// MARK: - PREVIEW
struct AddJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        AddJourneyView()
    }
}

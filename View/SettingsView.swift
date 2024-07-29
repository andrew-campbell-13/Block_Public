//
//  SettingsView.swift
//  Block
//
//  Created by Andrew Campbell on 26/9/2023.
//

import SwiftUI

// setings page for the app
struct SettingsView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: Settings

    let pressTimes = ["Instant", "short", "medium", "long"]
    let colors = ["blue", "orange", "yellow", "green", "pink", "purple"]
    let backgroundColors = ["black", "beige"]
    
    // MARK: - FUNCTIONS
    func exitView() {
        dismiss()
    }
    
    // MARK: - BODY
    var body: some View {
        let themeColor = getColor(colorString: settings.mainThemeColor)
        
        VStack(alignment: .center){
            Spacer()
            Text("Settings")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .font(.system(size: 50))
                .fontWeight(.bold)

            Form(){
                Section{
                    // toggle dark mode for app
                    Toggle("Dark Mode", isOn: settings.$darkMode).toggleStyle(SwitchToggleStyle(tint: getColor(colorString: settings.mainThemeColor))).padding(.bottom, 5)
                        .listRowBackground(settings.darkMode ? Color.black.edgesIgnoringSafeArea(.all) :  Color("Beige").edgesIgnoringSafeArea(.all))
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                    
                    // choose how long user has to press progress button to add block to journey
                    Picker("Button Press Time", selection: settings.$buttonPressTime){
                        ForEach(pressTimes, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .listRowBackground(settings.darkMode ? Color.black.edgesIgnoringSafeArea(.all) :  Color("Beige").edgesIgnoringSafeArea(.all))
                    .accentColor(settings.darkMode ? themeColor : .black)
                    
                    // choose theme color for app
                    Picker("Theme Color", selection: settings.$mainThemeColor){
                        ForEach(colors, id: \.self){ color in
                            Text(color)
                        }
                    }
                    .pickerStyle(.menu)
                    .listRowBackground(settings.darkMode ? Color.black.edgesIgnoringSafeArea(.all) :  Color("Beige").edgesIgnoringSafeArea(.all))
                    .accentColor(settings.darkMode ? themeColor : .black)
                    
                    
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 2)
                )
                .listRowSeparator(.hidden)
                
                HStack{
                    Spacer()
                    ViewModifierButton(action: exitView, displayString: "house", color: themeColor, fontSize: 30, isImage: true, isDisabled: false)
                    Spacer()
                }
                .listRowBackground(settings.darkMode ? Color.black.edgesIgnoringSafeArea(.all) :  Color("Beige").edgesIgnoringSafeArea(.all))
            }//: FORM  END
            Spacer()
        }//: VSTACK END
        .navigationBarHidden(true)
        .scrollContentBackground(.hidden)
        .background(settings.darkMode ? Color.black.edgesIgnoringSafeArea(.all) :  Color("Beige").edgesIgnoringSafeArea(.all))
        .foregroundColor(settings.darkMode ? themeColor : .black)
    }
}

// MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

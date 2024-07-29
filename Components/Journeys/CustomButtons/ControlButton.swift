//
//  ControlButton.swift
//  Block
//
//  Created by Andrew Campbell on 13/10/2023.
//

import SwiftUI

// Control Button component is for the buttons that allow the user to view the  next of previous active journey
struct ControlButton: View {
    // MARK: - PROPERTIES
    @StateObject private var settings = Settings()
    var action: () -> Void
    var imageString: String
    var color: Color
   
    // MARK: - BODY
    var body: some View {
        if(settings.darkMode){
            Button(action: {
                action()
            }){
                Image(systemName: imageString)
            }
            .font(.system(size: 50))
            .frame(width: 100, height: 100)
            .background(color)
            .foregroundColor(getColor(colorString: settings.darkMode ? "black" : "beige" ))
            .cornerRadius(10)
           
        }else{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .frame(width: 100, height: 100)
                Button(action: {
                    action()
                }){
                    Image(systemName: imageString)
                }
                .font(.system(size: 50))
                .frame(width: 94, height: 94)
         
                .background(getColor(colorString:  "beige" ))
                .foregroundColor(.black)
                .cornerRadius(8)
            }
        }
        
    }
}

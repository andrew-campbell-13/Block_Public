//
//  ViewModifierButton.swift
//  Block
//
//  Created by Andrew Campbell on 7/10/2023.
//

import SwiftUI

// Each ViewModifierButton, like all components, will adapt its styling based on the dark mode setting
struct ViewModifierButton: View {
    // MARK: - PROPERTIES
    @StateObject private var settings = Settings()
    var action: () -> Void // When button is pressed, execute the function passed to this component
    var displayString: String
    var color: Color
    var fontSize: CGFloat
    var isImage: Bool
    var isDisabled: Bool

    // MARK: - BODY
    var body: some View {
        if(settings.darkMode){
            Button(action: {
                action()
            }){
                if(isImage){
                    Image(systemName: displayString)
                }else{
                    Text(displayString)
                }
            }
            .disabled(isDisabled)
            .font(.system(size: fontSize))
            .frame(width: fontSize+25, height: fontSize+25)
            .background(color)
            .foregroundColor(.black)
            .cornerRadius(10)
            .opacity(isDisabled ? 0.5 : 1.0)
            .buttonStyle(BorderlessButtonStyle())
        }else{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .frame(width: fontSize+25, height: fontSize+25)
                Button(action: {
                    action()
                }){
                    if(isImage){
                        Image(systemName: displayString)
                    }else{
                        Text(displayString)
                    }
                }
                .disabled(isDisabled)
                .frame(width: fontSize+21, height: fontSize+21)
                .background(getColor(colorString: "beige" ))
                .foregroundColor(isDisabled ? .gray : .black)
                .cornerRadius(9)
                .opacity(isDisabled ? 0.5 : 1.0)
                .buttonStyle(BorderlessButtonStyle())
            }.font(.system(size: fontSize))
        }

    }
}


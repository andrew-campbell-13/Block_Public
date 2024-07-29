//
//  IncrementProgressButton.swift
//  Block
//
//  Created by Andrew Campbell on 13/10/2023.
//

import SwiftUI

// This button is pushed by the user when they want to record progress in a journey (add a block)
struct IncrementProgressButton: View {
    // MARK: - PROPERTIES
    @StateObject private var settings = Settings()
    @GestureState var press = false;
    var action: () -> Void
    var imageString_default: String
    var imageString_pressed: String
    var color: Color
    
    // MARK: - BODY
    var body: some View {
        if(settings.darkMode){
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 100)
                    .foregroundColor(color)
                ZStack{
                    Image(systemName: press ? imageString_pressed : imageString_default)
                        .font(.system(size: 60))
                        .background(color)
                }
            }
            .gesture(
                LongPressGesture(minimumDuration: getPressTime(buttonPressTime: settings.buttonPressTime))
                    .updating($press) { currentState, gestureState, transaction in
                        gestureState = currentState
                    }
                    .onEnded { value in
                        action()
                    }
            )
        }else{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .frame(width: 100, height: 100)
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 94, height: 94)
                        .foregroundColor(getColor(colorString: settings.darkMode ? "black" : "beige" ))
                    ZStack{
                        Image(systemName: press ? imageString_pressed : imageString_default)
                            .font(.system(size: 60))
                            .background(getColor(colorString: settings.darkMode ? "black" : "beige" ))
                    }
                    
                    
                }
                .gesture(
                    LongPressGesture(minimumDuration: getPressTime(buttonPressTime: settings.buttonPressTime))
                        .updating($press) { currentState, gestureState, transaction in
                            gestureState = currentState
                        }
                        .onEnded { value in
                            action()
                        }
                )
            }
        }
        
    }
}

// MARK: - PREVIEW

//struct IncrementProgressButton_Previews: PreviewProvider {
//    static var previews: some View {
//        IncrementProgressButton()
//    }
//}

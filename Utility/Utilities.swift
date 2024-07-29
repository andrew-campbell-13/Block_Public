//
//  Utilities.swift
//  Block
//
//  Created by Andrew Campbell on 22/9/2023.
//

import Foundation
import SwiftUI

// from the saved String color get the App Color
public func getColor(colorString: String) -> Color{
    var color: Color
    switch colorString{
    case "orange":
        color = Color("Orange")
    case "blue":
        color = Color("Blue")
    case "yellow":
        color = Color("Yellow")
    case "purple":
        color = Color("Purple")
    case "pink":
        color = Color("Pink")
    case "green":
        color = Color("Green")
    case "beige":
        color = Color("Beige")
    case "black":
        color = Color("Black")
    default:
        print("couldn't find color \(colorString)  :(")
        color = Color("Purple")
    }
    return color
}

// convert the user setting block size to pixel size
public func getBlockEdgeSize(blockSize: String) -> CGFloat{
    var edgeLength: CGFloat
    switch blockSize{
    case "Small":
        edgeLength = 15
    case "Medium":
        edgeLength = 25
    case "Large":
        edgeLength = 35
    default:
        edgeLength = 25
    }
    return edgeLength
}


// convert the time setting to a long press time when adding block
public func getPressTime(buttonPressTime: String) -> Double{
    var timer: Double
    switch buttonPressTime{
    case "Instant":
        timer = 0.05
    case "Short":
        timer = 0.5
    case "Medium":
        timer = 1
    case "Large":
        timer = 1.5
    default:
        timer = 1
    }
    return timer
}

// convert a category string to the category image
public func getCategorySymbol(inputString: String) -> String{
    var image_string: String
    switch inputString{
    case "fitness":
        image_string = "heart"
    case "work":
        image_string = "hammer"
    case "study":
        image_string = "book"
    case "soul":
        image_string = "smiley"
    case "hobby":
        image_string = "paintbrush"
    case "cooking":
        image_string = "flame"
    default:
        print("couldn't find category  :(")
        image_string =  "book"
    }
    return image_string
}

// get all dates between two dates and return as array of Strings
func datesInRange(startDate: String, endDate: String) -> [String] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"


    // ensure end date > start date
    guard let startDate = dateFormatter.date(from: startDate),
          let endDate = dateFormatter.date(from: endDate),
          startDate <= endDate else {
        return []
    }
    
    var currentDate = startDate
    var dateArray: [String] = []
    
    while currentDate <= endDate {
        dateArray.append(dateFormatter.string(from: currentDate))
        if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) {
            currentDate = nextDate
        } else {
            break
        }
    }
    
    return dateArray
}

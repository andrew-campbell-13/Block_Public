//
//  SwiftUIView.swift
//  Block
//
//  Created by Andrew Campbell on 28/9/2023.
//

import SwiftUI

// Each Block Square represents a unit of progress in the Journey
struct BlockSquare: View {
    // MARK: - PROPERTIES
    @StateObject private var settings = Settings()
    @Environment(\.managedObjectContext) var moc
    
    let blockSize: CGFloat
    let blockColor: Color
    let cornerRadius: CGFloat

    // MARK: - BODY
    var body: some View {
        VStack{
            if(settings.darkMode){
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(blockColor)
                    .frame(width: blockSize, height: blockSize)
            }else{
                ZStack(alignment: .center){
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.black)
                        .frame(width: blockSize, height: blockSize)
                    RoundedRectangle(cornerRadius: cornerRadius-2)
                        .fill(blockColor)
                        .frame(width: blockSize-4, height: blockSize-4)
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct BlockSquare_Previews: PreviewProvider {
    static var previews: some View {
        BlockSquare(blockSize: 50, blockColor: .blue, cornerRadius: 10)
    }
}



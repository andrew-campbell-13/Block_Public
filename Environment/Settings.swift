//
//  Settings.swift
//  Block
//
//  Created by Andrew Campbell on 26/9/2023.
//

import SwiftUI

@MainActor class Settings: ObservableObject {
    @AppStorage("darkMode") var darkMode: Bool = false
    @AppStorage("showTargetNumber") var showTargetNumber: Bool = false
    @AppStorage("showTargetBlocks") var showTargetBlocks: Bool = false
    @AppStorage("blockSize") var blockSize: String = "Medium"
    @AppStorage("buttonPressTime") var buttonPressTime: String = "Medium"
    @AppStorage("mainThemeColor") var mainThemeColor: String = "blue"
}

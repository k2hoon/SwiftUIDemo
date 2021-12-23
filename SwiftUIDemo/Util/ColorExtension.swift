//
//  ColorExtension.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/12/21.
//

import Foundation
import SwiftUI

extension Color {
    static let gray100 = Color(hex: "#f5f5f5")
    static let gray500 = Color(hex: "#9e9e9e")
    static let gray600 = Color(hex: "#757575")
    static let red700 = Color(hex: "#dd0d3c")
    static let red800 = Color(hex: "#d00036")
    static let red900 = Color(hex: "#c20029")
    static let red200 = Color(hex: "#f297a2")
    static let red300 = Color(hex: "#ea6d7e")
    static let green300 = Color(hex: "#81c784")
    static let blue700 = Color(hex: "#1976d2")
    static let cyan700 = Color(hex: "#0097a7")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xff) / 255.0
        let green = Double((rgb >> 8) & 0xff) / 255.0
        let blue = Double((rgb >> 0) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
    
    init(hex: UInt, alplha: Double = 1) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xff) / 255.0,
                  green: Double((hex >> 8) & 0xff) / 255.0,
                  blue: Double((hex >> 0) & 0xff) / 255.0,
                  opacity: alplha)
    }
}

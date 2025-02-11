//
//  Color_ext.swift
//  PizzaMoney
//
//  Created by Armando on 07/02/25.
//
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let red = Double((int >> 16) & 0xff) / 255
        let green = Double((int >> 8) & 0xff) / 255
        let blue = Double(int & 0xff) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
    }
}

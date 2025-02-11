//
//  ThemeSetting.swift
//  PizzaMoney
//
//  Created by san004 on 11/02/25.
//

import Foundation

enum ThemeSetting: Int {
    case light
    case dark
    case system
    
    static var allCases: [ThemeSetting] {
        return [.system, .light, .dark]
    }
    
    var name: String {
        switch self {
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        case .system:
            return "System"
        }
    }
}

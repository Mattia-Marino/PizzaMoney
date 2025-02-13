//
//  ThemeSetting.swift
//  PizzaMoney
//
//  Created by san004 on 11/02/25.
//

import Foundation
import SwiftUI

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
    
    var setting: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}

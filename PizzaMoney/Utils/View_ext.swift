//
//  Untitled.swift
//  PizzaMoney
//
//  Created by armando on 12/02/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func applyTheme(_ theme: ThemeSetting) -> some View {
        if theme != .system {
            self.environment(\.colorScheme, theme.setting!)
        } else {
            self // Do not override, use the system default
        }
    }
}

//
//  SubCategory.swift
//  PizzaMoney
//
//  Created by san017 on 07/02/25.
//



import Foundation
import SwiftData

@Model
class SubCategory {
    var id = UUID()
    var title: String
    var icon: String? = nil
    var color: String = "#000000" //TODO: func to generate random color
    
    init(title: String, icon: String? = nil, color: String = "#000000") {
        self.title = title
        self.icon = icon
        self.color = color
    }
}

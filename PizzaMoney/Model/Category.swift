//
//  CategoryItem.swift
//  PizzaMoney
//
//  Created by Armando on 05/02/25.
//

import Foundation
import SwiftData

@Model
final class Category : SubCategory {
    var icon: String? = nil
    var color: String = "#000000" //TODO: func to generate random color
    var subCategories: Array<SubCategory> = []
    
    init(title: String, icon: String? = nil, color: String = "#000000") {
        self.title = title
        self.icon = icon
        self.color = color
    }
}

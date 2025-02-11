//
//  SubCategory.swift
//  PizzaMoney
//
//  Created by Armando on 05/02/25.
//

import Foundation
import SwiftData

@Model
class Category {
    var id = UUID()
    var title: String
    var icon: String? = nil
    var color: String = "#000000" //TODO: func to generate random color
    var subCategories: [SubCategory] = []
        
    init(id: UUID = UUID(), title: String, icon: String? = nil, color: String) {
        self.id = id
        self.title = title
        self.icon = icon
        self.color = color
        self.subCategories = []
        
        subCategories.append(SubCategory(title: "other", category: self))
    }

}

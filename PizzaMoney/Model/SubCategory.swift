//
//  SubCategory.swift
//  PizzaMoney
//
//  Created by san017 on 11/02/25.
//


import Foundation
import SwiftData

@Model
class SubCategory {
    var id = UUID()
    var title: String
    var category : Category

    
    init(id: UUID = UUID(), title: String, category: Category) {
        self.id = id
        self.title = title
        self.category = category
    }
}


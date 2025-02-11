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
    
    
    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title

    }
}

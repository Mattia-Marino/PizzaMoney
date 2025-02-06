//
//  SubCategory.swift
//  PizzaMoney
//
//  Created by Armando on 05/02/25.
//

import Foundation
import SwiftData

@Model
class SubCategory {
    var id = UUID()
    var title: String
    
    init(title: String, icon: String) {
        self.title = title
    }
}

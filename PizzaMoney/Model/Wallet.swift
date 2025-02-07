//
//  SubCategory.swift
//  PizzaMoney
//
//  Created by Armando on 06/02/25.
//
import Foundation
import SwiftData

@Model
class Wallet {
    var id = UUID()
    var name: String
    var initialAmount: Double
    var transactions: [Transaction] = []
    
    init(name: String, initialAmount: Double) {
        self.name = name
        self.initialAmount = initialAmount
    }
}

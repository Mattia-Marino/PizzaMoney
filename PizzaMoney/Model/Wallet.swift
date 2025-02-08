//
//  SubCategory.swift
//  PizzaMoney
//
//  Created by Armando on 06/02/25.
//
import Foundation
import SwiftData

@Model
class Wallet : Identifiable {
    @Attribute(.unique) var id = UUID()
    var name: String
    var initialAmount: Double
    var transactions: [Transaction] = []
    
    init(name: String, initialAmount: Double) {
        self.name = name
        self.initialAmount = initialAmount
    }
    
    var totalAmount: Double {
        let transactionSum = transactions.reduce(0) { result, transaction in
            switch transaction.transactionType {
            case .income:
                return result + transaction.amount
            case .expense:
                return result - transaction.amount
            }
        }
        return initialAmount + transactionSum
    }
    
    func totalTransactions(from startDate: Date, to endDate: Date) -> Double {
        let filteredTransactions = transactions.filter { transaction in
            transaction.date >= startDate && transaction.date <= endDate
        }
        
        // Se non ci sono transazioni valide, ritorna 0
        guard !filteredTransactions.isEmpty else { return 0 }

        let transactionSum = filteredTransactions.reduce(0) { result, transaction in
            switch transaction.transactionType {
            case .income:
                return result + transaction.amount
            case .expense:
                return result - transaction.amount
            }
        }

        return transactionSum
    }

    
    func categoriesWithTotals(from startDate: Date, to endDate: Date) -> [(Category, Double)] {
        var categoryTotals: [Category: Double] = [:]
        
        for transaction in transactions {
            // Check if transaction falls within the date range
            if transaction.date >= startDate && transaction.date <= endDate {
                guard let category = transaction.category else { continue }
                let currentTotal = categoryTotals[category] ?? 0.0
                
                let adjustedAmount = transaction.transactionType == .income ? transaction.amount : -transaction.amount
                categoryTotals[category] = currentTotal + adjustedAmount
            }
        }
        
        return categoryTotals.map { ($0.key, $0.value) }
    }
    
    func transactionsForCategory(_ categoryTitle: String, from startDate: Date, to endDate: Date) -> [Transaction] {
        return transactions.filter {
            $0.category?.title == categoryTitle &&
            $0.date >= startDate &&
            $0.date <= endDate
        }
    }
}

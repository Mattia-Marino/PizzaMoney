//
//  MockData.swift
//  PizzaMoney
//
//  Created by san005 on 07/02/25.
//

import Foundation

func randomDate(from startDate: Date, to endDate: Date) -> Date {
    guard startDate <= endDate else {
        fatalError("Start date must be earlier than or equal to end date.")
    }

    let interval = endDate.timeIntervalSince(startDate)
    let randomInterval = TimeInterval.random(in: 0...interval)
    
    return startDate.addingTimeInterval(randomInterval)
}

let startDate = Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date()), month: 1, day: 1))!
let endDate = Date()

// Categorie
//let healthCategory = Category(title: "Health", icon: "heart.fill", color: "#E74C3C")
//let shoppingCategory = Category(title: "Shopping", icon: "bag.fill", color: "#F39C12")
//let travelCategory = Category(title: "Travel", icon: "airplane.fill", color: "#1ABC9C")

// Generate transactions with random dates
/*let extraTransactions: [Transaction] = (1...60).map { index in
    let category = [healthCategory, shoppingCategory, travelCategory].randomElement()
    let transactionType: TransactionType = Bool.random() ? .income : .expense
    let amount = Double.random(in: 10.0...1500.0)
    let randomDate = randomDate(from: startDate, to: endDate)
    
    return Transaction(
        title: "Transaction \(index)",
        date: randomDate,
        amount: amount,
        transactionType: transactionType,
        category: category
    )
}*/

/*func createMockWallets() -> [Wallet] {
    let mainWallet = Wallet(name: "Contesa San Francesco", initialAmount: 1000.00)
    mainWallet.transactions.append(contentsOf: extraTransactions.prefix(20))

    let vacationWallet = Wallet(name: "Banca Inulia", initialAmount: 500.00)
    vacationWallet.transactions.append(contentsOf: extraTransactions[20..<40])

    let savingsWallet = Wallet(name: "Banana Republic", initialAmount: 2000.00)
    savingsWallet.transactions.append(contentsOf: extraTransactions[40..<60])

    return [mainWallet, vacationWallet, savingsWallet]
}*/

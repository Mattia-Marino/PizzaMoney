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



struct mockDataCreate {
    let transactions:[Transaction]
    let categories:[Category]
    let wallets:[Wallet]
}


func createMock() -> mockDataCreate {
    let healthCategory = Category(title: "Health", icon: "heart.fill", color: "#E74C3C", subCategories:[])
    let shoppingCategory = Category(title: "Shopping", icon: "bag.fill", color: "#F39C12", subCategories:[])
    let travelCategory = Category(title: "Travel", icon: "airplane.fill", color: "#1ABC9C", subCategories:[])
    let foodCategory = Category(title: "Food", icon: "cart.fill", color: "#FF5733", subCategories:[])
    let entertainmentCategory = Category(title: "Entertainment", icon: "gamecontroller.fill", color: "#9B59B6", subCategories:[])
    let educationCategory = Category(title: "Education", icon: "book.fill", color: "#2980B9", subCategories:[])
    let utilitiesCategory = Category(title: "Utilities", icon: "bolt.fill", color: "#F1C40F", subCategories:[])
    let rentCategory = Category(title: "Rent", icon: "house.fill", color: "#8E44AD", subCategories:[])
    let investmentCategory = Category(title: "Investment", icon: "chart.line.uptrend.xyaxis", color: "#27AE60", subCategories:[])

    //subcategories

    // Health Category
    let subCategory1_1 = SubCategory(title: "Doctor Visits", category: healthCategory)
    let subCategory1_2 = SubCategory(title: "Medications", category: healthCategory)
    let subCategory1_3 = SubCategory(title: "Health Insurance", category: healthCategory)
    let subCategory1_4 = SubCategory(title: "other", category: healthCategory)
    healthCategory.subCategories.append(contentsOf: [subCategory1_4,subCategory1_1, subCategory1_2, subCategory1_3,subCategory1_4])

    // Shopping Category
    let subCategory2_1 = SubCategory(title: "Clothing", category: shoppingCategory)
    let subCategory2_2 = SubCategory(title: "Electronics", category: shoppingCategory)
    let subCategory2_3 = SubCategory(title: "Groceries", category: shoppingCategory)
    let subCategory2_4 = SubCategory(title: "other", category: shoppingCategory)
    
    shoppingCategory.subCategories.append(contentsOf: [subCategory2_4,subCategory2_1, subCategory2_2, subCategory2_3])

    // Travel Category
    let subCategory3_1 = SubCategory(title: "Destinations", category: travelCategory)
    let subCategory3_2 = SubCategory(title: "Transportation", category: travelCategory)
    let subCategory3_3 = SubCategory(title: "Accommodation", category: travelCategory)
    let subCategory3_4 = SubCategory(title: "other", category: shoppingCategory)
    
    travelCategory.subCategories.append(contentsOf: [subCategory3_4,subCategory3_1, subCategory3_2, subCategory3_3])

    // Food Category
    let subCategory4_1 = SubCategory(title: "Restaurants", category: foodCategory)
    let subCategory4_2 = SubCategory(title: "Groceries", category: foodCategory)
    let subCategory4_3 = SubCategory(title: "Takeout", category: foodCategory)
    let subCategory4_4 = SubCategory(title: "other", category: shoppingCategory)
    
    foodCategory.subCategories.append(contentsOf: [subCategory4_4,subCategory4_1, subCategory4_2, subCategory4_3])

    // Entertainment Category
    let subCategory5_1 = SubCategory(title: "Movies", category: entertainmentCategory)
    let subCategory5_2 = SubCategory(title: "Games", category: entertainmentCategory)
    let subCategory5_3 = SubCategory(title: "Music", category: entertainmentCategory)
    let subCategory5_4 = SubCategory(title: "other", category: shoppingCategory)
    
    entertainmentCategory.subCategories.append(contentsOf: [subCategory5_4,subCategory5_1, subCategory5_2, subCategory5_3])

    // Education Category
    let subCategory6_1 = SubCategory(title: "Books", category: educationCategory)
    let subCategory6_2 = SubCategory(title: "Online Courses", category: educationCategory)
    let subCategory6_3 = SubCategory(title: "School Fees", category: educationCategory)
    let subCategory6_4 = SubCategory(title: "other", category: shoppingCategory)
    
    educationCategory.subCategories.append(contentsOf: [subCategory6_4,subCategory6_1, subCategory6_2, subCategory6_3])

    // Utilities Category
    let subCategory7_1 = SubCategory(title: "Electricity", category: utilitiesCategory)
    let subCategory7_2 = SubCategory(title: "Water", category: utilitiesCategory)
    let subCategory7_3 = SubCategory(title: "Internet", category: utilitiesCategory)
    let subCategory7_4 = SubCategory(title: "other", category: shoppingCategory)
    
    utilitiesCategory.subCategories.append(contentsOf: [subCategory7_4,subCategory7_1, subCategory7_2, subCategory7_3])

    // Rent Category
    let subCategory8_1 = SubCategory(title: "Monthly Rent", category: rentCategory)
    let subCategory8_2 = SubCategory(title: "Maintenance", category: rentCategory)
    let subCategory8_3 = SubCategory(title: "Utilities", category: rentCategory)
    let subCategory8_4 = SubCategory(title: "other", category: shoppingCategory)
    
    rentCategory.subCategories.append(contentsOf: [subCategory8_4,subCategory8_1, subCategory8_2, subCategory8_3])

    // Investment Category
    let subCategory9_1 = SubCategory(title: "Stocks", category: investmentCategory)
    let subCategory9_2 = SubCategory(title: "Bonds", category: investmentCategory)
    let subCategory9_3 = SubCategory(title: "Real Estate", category: investmentCategory)
    let subCategory9_4 = SubCategory(title: "other", category: shoppingCategory)

    investmentCategory.subCategories.append(contentsOf: [subCategory9_4,subCategory9_1, subCategory9_2, subCategory9_3])
 
        
    let extraTransactions: [Transaction] = [
        Transaction(title: "Doctor Visit", date: startDate, amount: 80.0, transactionType: .expense, subCategory: subCategory1_1),
        Transaction(title: "Gym Membership", date: startDate.addingTimeInterval(86400), amount: 50.0, transactionType: .expense, subCategory: subCategory1_1),
        Transaction(title: "Online Course", date: startDate.addingTimeInterval(86400 * 2), amount: 120.0, transactionType: .expense, subCategory: subCategory6_1),
        Transaction(title: "Groceries", date: startDate.addingTimeInterval(86400 * 3), amount: 90.0, transactionType: .expense, subCategory: subCategory4_2),
        Transaction(title: "Dining Out", date: startDate.addingTimeInterval(86400 * 4), amount: 45.0, transactionType: .expense, subCategory: subCategory4_2),
        Transaction(title: "Cinema Ticket", date: startDate.addingTimeInterval(86400 * 5), amount: 12.0, transactionType: .expense, subCategory: subCategory5_1),
        Transaction(title: "Concert Ticket", date: startDate.addingTimeInterval(86400 * 6), amount: 150.0, transactionType: .expense, subCategory: subCategory5_1),
        Transaction(title: "Electricity Bill", date: startDate.addingTimeInterval(86400 * 7), amount: 60.0, transactionType: .expense, subCategory: subCategory7_1),
        Transaction(title: "Water Bill", date: startDate.addingTimeInterval(86400 * 8), amount: 40.0, transactionType: .expense, subCategory: subCategory7_2),
        Transaction(title: "Rent Payment", date: startDate.addingTimeInterval(86400 * 9), amount: 1000.0, transactionType: .expense, subCategory: subCategory8_1),
        Transaction(title: "Stock Investment", date: startDate.addingTimeInterval(86400 * 10), amount: 500.0, transactionType: .expense, subCategory: subCategory9_1),
        Transaction(title: "Dividend Income", date: startDate.addingTimeInterval(86400 * 11), amount: 200.0, transactionType: .income, subCategory: subCategory9_1),
        Transaction(title: "Flight Tickets", date: startDate.addingTimeInterval(86400 * 12), amount: 350.0, transactionType: .expense, subCategory: subCategory3_1),
        Transaction(title: "Hotel Booking", date: startDate.addingTimeInterval(86400 * 13), amount: 600.0, transactionType: .expense, subCategory: subCategory3_1),
        Transaction(title: "Freelance Work", date: startDate.addingTimeInterval(86400 * 14), amount: 1500.0, transactionType: .income),
        Transaction(title: "Tax Refund", date: startDate.addingTimeInterval(86400 * 15), amount: 450.0, transactionType: .income),
        Transaction(title: "Clothing Purchase", date: startDate.addingTimeInterval(86400 * 16), amount: 70.0, transactionType: .expense, subCategory: subCategory2_1),
        Transaction(title: "Car Service", date: startDate.addingTimeInterval(86400 * 17), amount: 200.0, transactionType: .expense, subCategory: subCategory7_3),
        Transaction(title: "Birthday Gift", date: startDate.addingTimeInterval(86400 * 18), amount: 100.0, transactionType: .expense, subCategory: subCategory2_1),
        Transaction(title: "Grocery Shopping", date: startDate.addingTimeInterval(86400 * 19), amount: 75.50, transactionType: .expense, subCategory: subCategory4_2),
        Transaction(title: "New Shoes", date: startDate.addingTimeInterval(86400 * 20), amount: 120.00, transactionType: .expense, subCategory: subCategory2_1),
        Transaction(title: "Weekend Trip", date: startDate.addingTimeInterval(86400 * 21), amount: 400.00, transactionType: .expense, subCategory: subCategory3_1),
        Transaction(title: "Movie Night", date: startDate.addingTimeInterval(86400 * 22), amount: 25.00, transactionType: .expense, subCategory: subCategory5_1),
        Transaction(title: "Online Course", date: startDate.addingTimeInterval(86400 * 23), amount: 99.00, transactionType: .expense, subCategory: subCategory6_1),
        Transaction(title: "Gas Bill", date: startDate.addingTimeInterval(86400 * 24), amount: 70.00, transactionType: .expense, subCategory: subCategory7_1),
        Transaction(title: "Rent", date: startDate.addingTimeInterval(86400 * 25), amount: 1200.00, transactionType: .expense, subCategory: subCategory8_1),
        Transaction(title: "Stock Purchase", date: startDate.addingTimeInterval(86400 * 26), amount: 250.00, transactionType: .expense, subCategory: subCategory9_1),
        Transaction(title: "Salary", date: startDate.addingTimeInterval(86400 * 27), amount: 2000.00, transactionType: .income),
        Transaction(title: "Coffee", date: startDate.addingTimeInterval(86400 * 28), amount: 5.00, transactionType: .expense, subCategory: subCategory4_1),
        Transaction(title: "New Dress", date: startDate.addingTimeInterval(86400 * 29), amount: 85.00, transactionType: .expense, subCategory: subCategory2_1),
        Transaction(title: "Business Trip", date: startDate.addingTimeInterval(86400 * 30), amount: 600.00, transactionType: .expense, subCategory: subCategory3_1),
        Transaction(title: "Board Game Night", date: startDate.addingTimeInterval(86400 * 31), amount: 15.00, transactionType: .expense, subCategory: subCategory5_1),
        Transaction(title: "Textbook", date: startDate.addingTimeInterval(86400 * 32), amount: 60.00, transactionType: .expense, subCategory: subCategory6_1),
        Transaction(title: "Phone Bill", date: startDate.addingTimeInterval(86400 * 33), amount: 50.00, transactionType: .expense, subCategory: subCategory7_3),
        Transaction(title: "Rent", date: startDate.addingTimeInterval(86400 * 34), amount: 1200.00, transactionType: .expense, subCategory: subCategory8_1),
        Transaction(title: "Mutual Fund Investment", date: startDate.addingTimeInterval(86400 * 35), amount: 300.00, transactionType: .expense, subCategory: subCategory9_1),
        Transaction(title: "Project Bonus", date: startDate.addingTimeInterval(86400 * 36), amount: 500.00, transactionType: .income),
        Transaction(title: "Groceries", date: startDate.addingTimeInterval(86400 * 37), amount: 65.00, transactionType: .expense, subCategory: subCategory4_2),
        Transaction(title: "Luxury Watch", date: startDate.addingTimeInterval(86400 * 38), amount: 950.00, transactionType: .expense, subCategory: subCategory2_1),
        Transaction(title: "Family Vacation", date: startDate.addingTimeInterval(86400 * 39), amount: 2500.00, transactionType: .expense, subCategory: subCategory3_1),
        Transaction(title: "Amusement Park Tickets", date: startDate.addingTimeInterval(86400 * 40), amount: 150.00, transactionType: .expense, subCategory: subCategory5_1),
        Transaction(title: "Online Learning Subscription", date: startDate.addingTimeInterval(86400 * 41), amount: 29.00, transactionType: .expense, subCategory: subCategory6_1),
        Transaction(title: "Internet Bill", date: startDate.addingTimeInterval(86400 * 42), amount: 55.00, transactionType: .expense, subCategory: subCategory7_2),
        Transaction(title: "Rent Payment", date: startDate.addingTimeInterval(86400 * 43), amount: 1200.00, transactionType: .expense, subCategory: subCategory8_1),
        Transaction(title: "Stock Dividends", date: startDate.addingTimeInterval(86400 * 44), amount: 350.00, transactionType: .income, subCategory: subCategory9_1),
        Transaction(title: "Freelance Gig", date: startDate.addingTimeInterval(86400 * 45), amount: 800.00, transactionType: .income),
        Transaction(title: "Supermarket Shopping", date: startDate.addingTimeInterval(86400 * 46), amount: 120.00, transactionType: .expense, subCategory: subCategory4_2),
        Transaction(title: "Sneakers Purchase", date: startDate.addingTimeInterval(86400 * 47), amount: 150.00, transactionType: .expense, subCategory: subCategory2_1),
        Transaction(title: "Weekend Road Trip", date: startDate.addingTimeInterval(86400 * 48), amount: 500.00, transactionType: .expense, subCategory: subCategory3_1),
        Transaction(title: "Streaming Service Subscription", date: startDate.addingTimeInterval(86400 * 49), amount: 12.99, transactionType: .expense, subCategory: subCategory5_1),
        Transaction(title: "Coding Bootcamp Fee", date: startDate.addingTimeInterval(86400 * 50), amount: 1500.00, transactionType: .expense, subCategory: subCategory6_2),
        Transaction(title: "Electricity Bill", date: startDate.addingTimeInterval(86400 * 51), amount: 70.00, transactionType: .expense, subCategory: subCategory7_1),
        Transaction(title: "Monthly Rent", date: startDate.addingTimeInterval(86400 * 52), amount: 1200.00, transactionType: .expense, subCategory: subCategory8_1),
        Transaction(title: "Cryptocurrency Investment", date: startDate.addingTimeInterval(86400 * 53), amount: 1000.00, transactionType: .expense, subCategory: subCategory9_1),
        Transaction(title: "Salary", date: startDate.addingTimeInterval(86400 * 54), amount: 3000.00, transactionType: .income),
        Transaction(title: "Bakery Shopping", date: startDate.addingTimeInterval(86400 * 55), amount: 25.00, transactionType: .expense, subCategory: subCategory4_1),
        Transaction(title: "Winter Jacket", date: startDate.addingTimeInterval(86400 * 56), amount: 180.00, transactionType: .expense, subCategory: subCategory2_1),
        Transaction(title: "International Flight", date: startDate.addingTimeInterval(86400 * 57), amount: 1200.00, transactionType: .expense, subCategory: subCategory3_1),
        Transaction(title: "Game Console", date: startDate.addingTimeInterval(86400 * 58), amount: 400.00, transactionType: .expense, subCategory: subCategory5_2),
        Transaction(title: "E-Learning Platform", date: startDate.addingTimeInterval(86400 * 59), amount: 80.00, transactionType: .expense, subCategory: subCategory6_2),
        Transaction(title: "Gas Payment", date: startDate.addingTimeInterval(86400 * 60), amount: 90.00, transactionType: .expense, subCategory: subCategory7_1),
        Transaction(title: "Monthly Rent", date: startDate.addingTimeInterval(86400 * 61), amount: 1200.00, transactionType: .expense, subCategory: subCategory8_1),
        Transaction(title: "Stock Portfolio Management Fee", date: startDate.addingTimeInterval(86400 * 62), amount: 150.00, transactionType: .expense, subCategory: subCategory9_1),
        Transaction(title: "Annual Bonus", date: startDate.addingTimeInterval(86400 * 63), amount: 5000.00, transactionType: .income)
    ]
    
    
    let mainWallet = Wallet(name: "Contesa San Francesco", initialAmount: 1000.00)
    mainWallet.transactions.append(contentsOf: extraTransactions.prefix(20))
    
    let vacationWallet = Wallet(name: "Banca Inulia", initialAmount: 500.00)
    vacationWallet.transactions.append(contentsOf: extraTransactions[20..<40])
    
    let savingsWallet = Wallet(name: "Banana Republic", initialAmount: 2000.00)
    savingsWallet.transactions.append(contentsOf: extraTransactions[40..<60])
    
    return mockDataCreate(
        transactions: extraTransactions,
        categories: [
            healthCategory,
            foodCategory,
            rentCategory,
            travelCategory,
            shoppingCategory,
            educationCategory,
            entertainmentCategory,
            investmentCategory
        ], wallets: [
            mainWallet,
            vacationWallet,
            savingsWallet
        ]
        
    )
    
}

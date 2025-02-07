//
//  AllTransactionsView.swift
//  Exercises
//
//  Created by san013 on 07/02/25.
//

import SwiftUI
import Charts

struct AllTransactionsDataPoint: Identifiable {
    let id = UUID()
    let month: String
    let value: Double
    let category: String
}

let sampleAllTransactionsData: [AllTransactionsDataPoint] = [
    AllTransactionsDataPoint(month: "Jan", value: 50, category: "Expenses"),
    AllTransactionsDataPoint(month: "Feb", value: 80, category: "Expenses"),
    AllTransactionsDataPoint(month: "Mar", value: 45, category: "Expenses"),
    AllTransactionsDataPoint(month: "Apr", value: 60, category: "Expenses"),
    AllTransactionsDataPoint(month: "May", value: 90, category: "Expenses"),
    AllTransactionsDataPoint(month: "Jun", value: 70, category: "Expenses"),
    AllTransactionsDataPoint(month: "Jan", value: 30, category: "Income"),
    AllTransactionsDataPoint(month: "Feb", value: 60, category: "Income"),
    AllTransactionsDataPoint(month: "Mar", value: 25, category: "Income"),
    AllTransactionsDataPoint(month: "Apr", value: 50, category: "Income"),
    AllTransactionsDataPoint(month: "May", value: 70, category: "Income"),
    AllTransactionsDataPoint(month: "Jun", value: 90, category: "Income")
]

struct AllTransactionsLineChartView: View {
    var data: [AllTransactionsDataPoint]
    
    var body: some View {
        Chart(data) { point in
            LineMark(
                x: .value("Month", point.month),
                y: .value("Value", point.value)
            )
            .foregroundStyle(by: .value("Category", point.category))
        }
        .chartForegroundStyleScale([
            "Expenses": .blue,
            "Income": .green
        ])
        .chartXAxisLabel("Month")
        .chartYAxisLabel("Value")
        .frame(height: 300)
        .padding()
    }
}

struct AllTransactionsChartsView: View {
    var body: some View {
        VStack{
            AllTransactionsLineChartView(data: sampleAllTransactionsData)
                .padding([.leading])
        }.background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
            .padding()
    }
}

#Preview {
    AllTransactionsChartsView()
}

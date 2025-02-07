//
//  IncomeTransactionsChartsView.swift
//  PizzaMoney
//
//  Created by san013 on 07/02/25.
//

import SwiftUI
import Charts

let incomeTransactionsSampleData: [IncomeTransactionsDataPoint] = [
    IncomeTransactionsDataPoint(month: "Jan", value: 50),
    IncomeTransactionsDataPoint(month: "Feb", value: 80),
    IncomeTransactionsDataPoint(month: "Mar", value: 45),
    IncomeTransactionsDataPoint(month: "Apr", value: 60),
    IncomeTransactionsDataPoint(month: "May", value: 90),
    IncomeTransactionsDataPoint(month: "Jun", value: 70)
]

struct IncomeTransactionsChartsView: View {
    var body: some View {
        VStack{
            LineIncomeTransactionsChartView(data: incomeTransactionsSampleData)
                .padding([.leading])
        }.background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
            .padding()
    }
}

struct LineIncomeTransactionsChartView: View {
    var data: [IncomeTransactionsDataPoint]
    
    var body: some View {
        Chart(data) { point in
            LineMark(
                x: .value("Month", point.month),
                y: .value("Value", point.value)
            )
        }.foregroundStyle(.green)
        .chartXAxisLabel("Month")
        .chartYAxisLabel("Value")
        .frame(height: 300)
        .padding()
    }
}

struct IncomeTransactionsDataPoint: Identifiable {
    let id = UUID()
    let month: String
    let value: Double
}


#Preview {
    IncomeTransactionsChartsView()
}

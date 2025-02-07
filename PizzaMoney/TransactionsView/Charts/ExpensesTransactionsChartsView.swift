//

//  PizzaMoney
//
//  Created by san013 on 07/02/25.
//

import SwiftUI
import Charts

let expensesTransactionsSampleData: [ExpensesTransactionsDataPoint] = [
    ExpensesTransactionsDataPoint(month: "Jan", value: 50),
    ExpensesTransactionsDataPoint(month: "Feb", value: 80),
    ExpensesTransactionsDataPoint(month: "Mar", value: 45),
    ExpensesTransactionsDataPoint(month: "Apr", value: 60),
    ExpensesTransactionsDataPoint(month: "May", value: 90),
    ExpensesTransactionsDataPoint(month: "Jun", value: 70)
]

struct ExpensesTransactionsChartsView: View {
    var body: some View {
        VStack{
            LineExpensesdTransactionsChartView(data: expensesTransactionsSampleData)
                .padding([.leading])
        }.background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
            .padding()
    }
}

struct LineExpensesdTransactionsChartView: View {
    var data: [ExpensesTransactionsDataPoint]
    
    var body: some View {
        Chart(data) { point in
            LineMark(
                x: .value("Month", point.month),
                y: .value("Value", point.value)
            )
        }//.foregroundStyle(.red)
        .chartXAxisLabel("Month")
        .chartYAxisLabel("Value")
        .frame(height: 300)
        .padding()
    }
}

struct ExpensesTransactionsDataPoint: Identifiable {
    let id = UUID()
    let month: String
    let value: Double
}


#Preview {
    ExpensesTransactionsChartsView()
}

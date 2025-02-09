import SwiftUI
import SwiftData
import Charts

struct TransactionsListView: View {
    
    @State var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
    
    @State var endDate: Date = Date()
    
    @Query(sort: [SortDescriptor(\Wallet.timestamp)]) var wallets: [Wallet]
    
    @State var currentWallet: Wallet?
    
    var filteredTransactions: [Transaction] {
        guard let currentWallet = currentWallet else { return [] }
        return currentWallet.transactions
            .filter { $0.date >= startDate && $0.date <= endDate }
    }
    
    var body: some View {
        
        VStack {
            
            CarouselView(wallets: wallets, selected: $currentWallet)
                .padding(.bottom, 20)
            
            HStack {
                DatePicker("", selection: $startDate, displayedComponents: .date)
                    .labelsHidden()
                
                DatePicker("", selection: $endDate, displayedComponents: .date)
                    .labelsHidden()
            }
            
            if let currentWallet = currentWallet {
                let groupedTransactions = transactionsGroupedByDay(transactions: filteredTransactions)
                
                Chart {
                    ForEach(groupedTransactions, id: \.0) { (date, transactions) in
                        if let incomes = transactions["income"] {
                            BarMark(
                                x: .value("Date", date, unit: .day),
                                y: .value("Income Total", incomes.reduce(0) { $0 + $1.amount })
                            )
                            .foregroundStyle(.green)
                        }
                        if let expenses = transactions["expense"] {
                            BarMark(
                                x: .value("Date", date, unit: .day),
                                y: .value("Expense Total", expenses.reduce(0) { $0 + $1.amount })
                            )
                            .foregroundStyle(.red)
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day)) {
                        AxisValueLabel(format: .dateTime.day().month())
                    }
                }
                .frame(width: 310, height: 270)
                
                List{
                    ForEach(filteredTransactions) {transaction in
                        RowView(transaction: transaction)
                    }
                }
                .frame(maxWidth: .infinity)
                .scrollContentBackground(.hidden)
                
            } else {
                Text("Select a wallet to display data")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
        }
        
        .navigationTitle("Totals")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct RowView: View {
    var transaction : Transaction
    
    var body: some View {
        HStack {
            
            let sign: String = transaction.transactionType == .income ? "+" : "-"
            let color: Color = transaction.transactionType == .income ? .green : .red
            
            Text(transaction.title)
            Spacer()
            Text(String(format: "\(sign)%.2f",transaction.amount))
                .foregroundStyle(color)
        }
    }
}

func transactionsGroupedByDay(transactions: [Transaction]) -> [(Date, [String: [Transaction]])] {
    
    let grouped = Dictionary(grouping: transactions) { Calendar.current.startOfDay(for: $0.date) }
    
    return grouped.map { day, transactions in
        let groupedByType = Dictionary(grouping: transactions) { $0.transactionType == .income ? "income" : "expense" }
        return (day, groupedByType)
    }.sorted { $0.0 < $1.0 }
}

#Preview {
    TransactionsListView()
        .modelContainer(previewContainer)
}

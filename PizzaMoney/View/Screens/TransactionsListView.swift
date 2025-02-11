import SwiftUI
import SwiftData
import Charts

struct TransactionsListView: View {
    
    @AppStorage("filter_startDate") var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
    
    @AppStorage("filter_endDate") var endDate: Date = Date()
    
    @Query(sort: [SortDescriptor(\Wallet.timestamp)]) var wallets: [Wallet]
    
    @State var currentWallet: Wallet?
    
    var filteredTransactions: [Transaction] {
        guard let currentWallet = currentWallet else { return [] }
        return currentWallet.transactions
            .filter { $0.date >= startDate && $0.date <= endDate }
    }
    
    var body: some View {
        
        NavigationStack {
            
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
                    
                    let interval = (endDate.timeIntervalSince(startDate)) / 5
                    
                    
                    let intermediateDates = (1...4).map { startDate.addingTimeInterval(Double($0) * interval) }
                    
                    Chart {
                        
                        ForEach(groupedTransactions, id: \.0) { (date, transactions) in
                            if let incomes = transactions["income"] {
                                BarMark(
                                    x: .value("Date", date),
                                    y: .value("Total", incomes.reduce(0) { $0 + $1.amount })
                                )
                                .foregroundStyle(.green)
                            }
                            
                            if let expenses = transactions["expense"] {
                                BarMark(
                                    x: .value("Date", date),
                                    y: .value("Total", expenses.reduce(0) { $0 - $1.amount }) // Negative expenses
                                )
                                .foregroundStyle(.red)
                            }
                        }
                        
                        ForEach(intermediateDates, id: \.self) { date in
                            RuleMark(x: .value("Date", date))
                                .lineStyle(.init(lineWidth: 1, dash: [5]))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: intermediateDates) {
                            AxisValueLabel(format: .dateTime.day().month())
                                .offset(x: -20)
                        }
                    }
                    .chartYAxis {
                        AxisMarks() {
                            AxisValueLabel()
                                .offset(x: 10) // Shift Y-axis labels left
                        }
                    }
                    .frame(width: 310, height: 250)
                    .padding(.top, 20)
                    
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
            
            .onAppear {
                Task {
                    if currentWallet == nil, let firstWallet = wallets.first {
                        await MainActor.run {
                            currentWallet = firstWallet
                        }
                    }
                }
            }
            
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Plus button was tapped")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
            
        }
        
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

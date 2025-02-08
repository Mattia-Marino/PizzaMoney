//
//  TotalsView.swift
//  PizzaMoney
//
//  Created by Armando on 03/02/25.
//

import SwiftUI
import Charts


struct TotalsView: View {
    
    @State var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
    
    @State var endDate: Date = Date()
    
    let wallets: [Wallet] = createMockWallets() //TODO: replace with actual query
    
    @State var currentWallet: Wallet?
    
    var body: some View {
        
        var categoriesInWallet = currentWallet?.categoriesWithTotals(from: startDate, to: endDate)
        
        var totalTransactions = currentWallet?.totalTransactions(
            from: startDate,
            to: endDate
        ) ?? 0
        
        var transactionsSign = totalTransactions < 0 ? "-" : "+"
        
        var transactionsColor = totalTransactions < 0 ? Color.red : Color.green
        
        NavigationStack{
            
            VStack{
                
                CarouselView(wallets: wallets, selected: $currentWallet)
                    .padding(.bottom, 20)
                
                
                HStack{
                    
                    DatePicker("", selection: $startDate,
                               displayedComponents: .date)
                    .labelsHidden()
                    
                    DatePicker("", selection: $endDate,
                               displayedComponents: .date)
                    .labelsHidden()
                    
                }
                
                Chart(categoriesInWallet ?? [], id: \.0.id) { (category, total) in
                    SectorMark(
                        angle: .value("Totals", total),
                        innerRadius: .ratio(0.618),
                        angularInset: 1.5
                    )
                    .cornerRadius(5)
                    .foregroundStyle(Color(hex: category.color))
                }
                .frame(width: 310, height: 270)
                .chartBackground { chartProxy in
                    GeometryReader { geometry in
                        let frame = geometry[chartProxy.plotAreaFrame]
                        VStack {
                            Text(
                                String(
                                    format: "\(transactionsSign)%.2f",
                                    currentWallet?.totalTransactions(
                                        from: startDate,
                                        to: endDate
                                    ) ?? 0
                                )
                            )
                            .font(.callout)
                            .foregroundStyle(transactionsColor)
                            Text(
                                String(
                                    format: "%.2f",
                                    currentWallet?.totalAmount ?? 0
                                )
                            )
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                            
                        }
                        .position(x: frame.midX, y: frame.midY)
                    }
                }
                
                List {
                    ForEach(categoriesInWallet?.map { $0.0 } ?? []) { category in
                        Text(category.title)
                    }
                }
                .frame(maxWidth: .infinity)
                .scrollContentBackground(.hidden)
                
            }
            
            
            
            
            .navigationTitle("Totals")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
        
        
    }
    
}

#Preview {
    TotalsView()
        .modelContainer(for: Transaction.self, inMemory: true)
}

//
//  TotalsView.swift
//  PizzaMoney
//
//  Created by Armando on 03/02/25.
//

import SwiftUI
import Charts


struct TotalsView: View {
    
    var body: some View {
        @State var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
        
        @State var endDate: Date = Date()
        
        var wallets = createMockWallets() //TODO: replace with actual query
        
        @State var currentWallet: Wallet? = wallets.first
        
        
        NavigationStack{
            VStack{
                
                CarouselView(wallets: wallets, selected: $currentWallet)
                    .padding(.bottom, 20)
                
                HStack{
                    
                    DatePicker("", selection: .constant(startDate),
                               displayedComponents: .date)
                    .labelsHidden()
                    
                    DatePicker("", selection: .constant(endDate),
                               displayedComponents: .date)
                    .labelsHidden()
                    
                }
            }
            
            Chart(Array(currentWallet?.totalsByCategory(from: startDate, to: endDate).map { (key, value) in
                (name: key, total: value)
            } ?? []), id: \.name) { element in
                SectorMark(
                    angle: .value("Totals", element.total),
                    innerRadius: .ratio(0.618),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Name", element.name))
            }
            .frame(width: 310, height: 270)
            .chartBackground { chartProxy in
                GeometryReader { geometry in
                    let frame = geometry[chartProxy.plotAreaFrame]
                    VStack {
                        Text("Most Sold Style")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text("Ciaone")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
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

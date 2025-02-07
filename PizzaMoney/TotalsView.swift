//
//  TotalsView.swift
//  PizzaMoney
//
//  Created by Armando on 03/02/25.
//

import SwiftUI


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
            
                .navigationTitle("Totals")
                
                .navigationBarTitleDisplayMode(.inline)
            
    
        
                
                
        }

    }

}

#Preview {
    TotalsView()
        .modelContainer(for: Transaction.self, inMemory: true)
}

//
//  TotalsView.swift
//  PizzaMoney
//
//  Created by Armando on 03/02/25.
//

import SwiftUI


struct TotalsView: View {

    var body: some View {
        var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
        
        
        NavigationStack{
            VStack{
                // Placeholder componente selettore conto
                
                HStack{
                    
                    DatePicker("", selection: .constant(startDate),
                               displayedComponents: .date)
                    .labelsHidden()
                    
                    DatePicker("", selection: .constant(Date()),
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
        .modelContainer(for: Item.self, inMemory: true)
}

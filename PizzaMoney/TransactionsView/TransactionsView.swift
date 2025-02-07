//
//  TransactionView.swift
//  Exercises
//
//  Created by san013 on 07/02/25.
//

import SwiftUI

struct TransactionView: View {
    @State private var typeSelected = 1

    var body: some View {
        NavigationView {
            VStack {
                Picker("Choose a day", selection: $typeSelected){
                    Text("Income").tag(0)
                    Text("All").tag(1)
                    Text("Expenses").tag(2)
                }.pickerStyle(.segmented)
                    .padding()
                TypologyTransactionsView(type: typeSelected)
                Spacer()
            }
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode( .inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                    }) {
                        Image(systemName: "plus")
                    }
                }
                
            }
        }
        
    }
}
@ViewBuilder
func TypologyTransactionsView(type: Int) -> some View {
    switch type {
    case 0:
        IncomeTransactionsChartsView()
    case 1:
        AllTransactionsChartsView()
    case 2:
        ExpensesTransactionsChartsView()
    default:
        Text("Other")
    }
}

struct ContentTransactionsView: View {
    let typology: String
    var body: some View {
        VStack{
            AllTransactionsChartsView()
            Text(typology)
        }
    }
}

#Preview {
    TransactionView().modelContainer(for: Transaction.self, inMemory: true)
}

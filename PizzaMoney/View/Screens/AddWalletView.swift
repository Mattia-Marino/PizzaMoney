//
//  AddWalletView.swift
//  PizzaMoney
//
//  Created by san013 on 11/02/25.
//

import SwiftUI
import SwiftData

struct AddWalletView: View {
    
    // MARK: - Properties
    
    @State private var walletName: String = ""
    @State private var initialAmount: String = ""
    @State private var selectedCurrency: String = "EUR"
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) var modelContext
    
    
    private var currencies: [String] = ["EUR", "USD", "JPY"]
    
    // MARK: - Body
    
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                TextField("Wallet Name...", text: $walletName)
                    .padding(.horizontal)
                Divider()
                TextField("Initial Amount...", text: $initialAmount)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
                Divider()
                HStack{
                    Text("Main Currency")
                    Spacer()
                    Picker(selection: $selectedCurrency, label: Text("Picker")) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency).tag(currency)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 100)
                }.padding(.horizontal)
                Divider()
                Spacer()
                
            }
            .navigationTitle("Add Wallet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        do {
                            let amount = try Double(self.initialAmount, format: .number)
                            
                            let wallet = Wallet(name: walletName, initialAmount:  amount)
                            modelContext.insert(wallet)
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("Failed to convert initial amout: \(error)")
                        }
                    } label: {
                        Text("Save")
                    }.disabled(walletName.isEmpty || initialAmount.isEmpty)
                }
            }
        }
    }
}


// MARK: - Preview

#Preview {
    AddWalletView()
}

//
//  AccountsWalletView.swift
//  PizzaMoney
//
//  Created by san015 on 07/02/25.
//

import SwiftUI
import _SwiftData_SwiftUI


struct AccountsWalletView: View {
    @Query(sort: [SortDescriptor(\Wallet.name)]) var wallets: [Wallet]
    
    private var totalValue: Double {
        let total = wallets.reduce(0) { result, wallet in
            return result + wallet.totalAmount
        }
        
        return total
    }
    
    @State private var isValueVisible: Bool = true

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Total Balance Card
                ZStack(alignment: .leading) {
                    Color(cardColor(for: totalValue))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Total")
                                .font(.system(size: 30))
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                            Spacer()
                            Button(action: {
                                isValueVisible.toggle()
                            }) {
                                Image(systemName: isValueVisible ? "eye.fill" : "eye.slash.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 34, height: 26)
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                        if isValueVisible {
                            HStack {
                                Spacer()
                                Text("€\(String(format: "%.2f", totalValue))")
                                    .font(.system(size: 45))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                    }
                    .padding()
                }
                .frame(width: 360, height: 170)

                // Wallets Section
                Text("WALLETS")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                VStack(spacing: 8) {
                    WalletCard(name: "Contesa San Francesco", amount: "€20.000,00")
                    WalletCard(name: "Banca Inulia", amount: "€12.524,98")
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationBarTitle("Accounts", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
            })
        }

        
    }

    func cardColor(for value: Double) -> UIColor {
        switch value {
        case ...0:
            return .red
        default:
            return .greenAccounts
        }
    }
}

struct WalletCard: View {
    var id: UUID = UUID()
    var name: String
    var amount: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color(.systemGray6)
                .cornerRadius(12)
                .shadow(radius: 5)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text("Total: \(amount)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding()
        }.frame(width: 360, height: 90)
    }
}


#Preview {
    AccountsWalletView()
        .modelContainer(previewContainer)
}

//
//  AccountsWalletView.swift
//  PizzaMoney
//
//  Created by san015 on 07/02/25.
//

import SwiftUI

struct AccountsWalletView: View {
    var value: Double

    var body: some View {
        ZStack {
            Color(cardColor(for: value))
                .cornerRadius(10)
                .shadow(radius: 5)
            
            VStack {
                Text("Card Value: \(String(format: "%.2f", value))")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .frame(width: 200, height: 100)
        Spacer()
    }

    func cardColor(for value: Double) -> UIColor {
        switch value {
        case ...0:
            return .red
        default:
            return .green
        }
    }
}

#Preview {
    AccountsWalletView(value: 0)
}

//
//  AccountsWalletView.swift
//  PizzaMoney
//
//  Created by san015 on 07/02/25.
//

import SwiftUI

struct AccountsWalletView: View {
    var value: Double
    @State private var isValueVisible: Bool = true

    var body: some View {
        ZStack {
            Color(cardColor(for: value))
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
                        Text("€\(String(format: "%.2f", value))")
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

#Preview {
    AccountsWalletView(value: 32524.98)
}

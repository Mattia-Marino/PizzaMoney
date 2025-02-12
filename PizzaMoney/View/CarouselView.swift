//
//  WalletsCaroueslView.swift
//  PizzaMoney
//
//  Created by Armando on 06/02/25.
//

import SwiftUI

struct CarouselView: View {
    
    var wallets : [Wallet]
    @Binding var selected : Wallet?
    
    let selectedColor = Color.blue
    let unselectedColor = Color.gray
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(wallets) { wallet in
                    Button(action: {
                        selected = wallet
                    }) {

                        Text(wallet.name)
                            .padding(10)

                            .background(
                                RoundedRectangle(cornerRadius: 50, style: .continuous)
                                    .fill(selected?.id == wallet.id ? selectedColor : unselectedColor)
                            )
                            .foregroundStyle(.white)
                            .font(.headline)
                    }.padding(.leading, wallets.first == wallet ? 60 : 0)
                        .padding(.trailing, wallets.last == wallet ? 60 : 0)
                    
                }
            }
            
        }.scrollIndicators(.hidden)
        
            .onAppear {
                selected = wallets.first
            }
    }
}


#Preview {
    @Previewable var wallets = createMockWallets()
    @Previewable @State var selected : Wallet? = nil
    CarouselView(wallets: wallets, selected: $selected)
}


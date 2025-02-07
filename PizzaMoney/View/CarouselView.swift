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
    
    //TODO: da cambiare quando lo schema dati sarà completato
    
    let selectedColor = Color.blue
    let unselectedColor = Color.gray
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(wallets) { wallet in
                    
                    let color = if selected == wallet {
                        selectedColor
                    } else {
                        unselectedColor
                    }
                                        
                    Button(action: {
                        selected = wallet
                    }) {
                        Text(wallet.name)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 50, style: .continuous).fill(color)
                            )
                            .foregroundStyle(.white)
                            .font(.headline)
                    }
                    
                }
            }
            
        }.scrollIndicators(.hidden)
    }
}


 #Preview {
     @Previewable var wallets = createMockWallets()
     @Previewable @State var selected : Wallet? = nil
     CarouselView(wallets: wallets, selected: $selected)
 }
 

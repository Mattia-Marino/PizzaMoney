//
//  WalletsCaroueslView.swift
//  PizzaMoney
//
//  Created by Armando on 06/02/25.
//

import SwiftUI

struct CarouselView: View {
    
    var banks : [String]
    @Binding var selected : String
    
    //TODO: da cambiare quando lo schema dati sarà completato
    
    let selectedColor = Color.blue
    let unselectedColor = Color.gray
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(banks, id: \.self) { bank in
                    
                    let color = if selected == bank {
                        selectedColor
                    } else {
                        unselectedColor
                    }
                                        
                    Button(action: {
                        selected = bank
                    }) {
                        Text(bank)
                            .padding(10)
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
    @Previewable var banks = ["Contesa San Paolo", "Banca Inulia", "BananaRepublic"]
    @Previewable @State var selected = "Contesa San Paolo"
    return CarouselView(banks: banks, selected: $selected)
}

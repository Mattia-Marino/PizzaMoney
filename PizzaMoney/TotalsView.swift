//
//  TotalsView.swift
//  PizzaMoney
//
//  Created by Armando on 03/02/25.
//

import SwiftUI


struct TotalsView: View {

    var body: some View {
        NavigationStack{
            Text("Hello World")
        }

    }

}

#Preview {
    TotalsView()
        .modelContainer(for: Item.self, inMemory: true)
}

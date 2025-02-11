//
//  TotalsView.swift
//  PizzaMoney
//
//  Created by Armando on 03/02/25.
//

import SwiftUI


struct TotalsView: View {

    @EnvironmentObject var appSharedState : AppSharedState
    var body: some View {
        NavigationStack{
           Text("totals view")
        }

    }

}

#Preview {
    TotalsView()
        .modelContainer(for: Transaction.self, inMemory: true)
}

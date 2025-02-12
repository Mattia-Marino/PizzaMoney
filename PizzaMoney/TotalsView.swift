//
//  TotalsView.swift
//  PizzaMoney
//
//  Created by Armando on 03/02/25.
//

import SwiftUI

import Charts
import _SwiftData_SwiftUI


struct TotalsView: View {
    
    @AppStorage("filter_startDate") var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
    
    @AppStorage("filter_endDate") var endDate: Date = Date()
    
    @Query(sort: [SortDescriptor(\Wallet.timestamp)]) var wallets: [Wallet]
    
    @State var currentWallet: Wallet?
    

    var body: some View {
        
        var categoriesInWallet = currentWallet?.categoriesWithTotals(from: startDate, to: endDate)
        
        var totalTransactions = currentWallet?.totalTransactions(
            from: startDate,
            to: endDate
        ) ?? 0
        
        /* Se l'ammontare è negativo il segno meno viene messo
         * inj automatico*/
        var transactionsSign = totalTransactions < 0 ? "" : "+"
        
        var transactionsColor = totalTransactions < 0 ? Color.red : Color.green
        
        NavigationStack{

            
            VStack{
                
                CarouselView(wallets: wallets, selected: $currentWallet)
                    .padding(.bottom, 20)
                
                
                HStack{
                    
                    DatePicker("", selection: $startDate,
                               displayedComponents: .date)
                    .labelsHidden()
                    
                    DatePicker("", selection: $endDate,
                               displayedComponents: .date)
                    .labelsHidden()
                    
                }
                
                Chart(categoriesInWallet ?? [], id: \.0.id) { (category, total) in
                    SectorMark(
                        angle: .value("Totals", total),
                        innerRadius: .ratio(0.618),
                        angularInset: 1.5
                    )
                    .cornerRadius(5)
                    .foregroundStyle(Color(hex: category.color))
                }
                .frame(width: 310, height: 270)
                .chartBackground { chartProxy in
                    GeometryReader { geometry in
                        let frame = geometry[chartProxy.plotAreaFrame]
                        VStack {
                            Text(
                                String(
                                    format: "\(transactionsSign)%.2f",
                                    currentWallet?.totalTransactions(
                                        from: startDate,
                                        to: endDate
                                    ) ?? 0
                                )
                            )
                            .font(.callout)
                            .foregroundStyle(transactionsColor)
                            Text(
                                String(
                                    format: "%.2f",
                                    currentWallet?.totalAmount ?? 0
                                )
                            )
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                            
                        }
                        .position(x: frame.midX, y: frame.midY)
                    }
                }
                
                List {
                    ForEach(categoriesInWallet?.map { $0.0 } ?? []) { category in
                        RowView(category: category)
                    }
                }
                .frame(maxWidth: .infinity)
                .scrollContentBackground(.hidden)
                
            }
            
            .onAppear {
                Task {
                    if currentWallet == nil, let firstWallet = wallets.first {
                        await MainActor.run {
                            currentWallet = firstWallet
                        }
                    }
                }
            }
            
            
            .navigationTitle("Totals")
            .navigationBarTitleDisplayMode(.inline)
            

        }
        
    }

    /*func loadCategories(){
        var category = Category(
            title: "Food",
            icon: "fork.knife",
            color: "#FF6347",
            subCategories: []
        )
        
        var subCategory1 = SubCategory(title: "Fruits",category: category)
        var subCategory2 = SubCategory(title: "Vegetables",category: category)
        var subCategory3 = SubCategory(title: "Meat",category: category)
        
        category.subCategories.append(contentsOf: [subCategory1,subCategory2,subCategory3])
        modelContext.insert(category)
        

        var category1 = Category(
            title: "Technology",
            icon: "desktopcomputer",
            color: "#1E90FF",
            subCategories: []
        )

        var subCategory1_1 = SubCategory(title: "Smartphones", category: category1)
        var subCategory1_2 = SubCategory(title: "Laptops", category: category1)
        var subCategory1_3 = SubCategory(title: "Wearables", category: category1)

        category1.subCategories.append(contentsOf: [subCategory1_1, subCategory1_2, subCategory1_3])
        modelContext.insert(category1)

        var category2 = Category(
            title: "Entertainment",
            icon: "film",
            color: "#FF69B4",
            subCategories: []
        )

        var subCategory2_1 = SubCategory(title: "Movies", category: category2)
        var subCategory2_2 = SubCategory(title: "Music", category: category2)
        var subCategory2_3 = SubCategory(title: "Video Games", category: category2)

        category2.subCategories.append(contentsOf: [subCategory2_1, subCategory2_2, subCategory2_3])
        modelContext.insert(category2)

        var category3 = Category(
            title: "Travel",
            icon: "airplane",
            color: "#32CD32",
            subCategories: []
        )

        var subCategory3_1 = SubCategory(title: "Destinations", category: category3)
        var subCategory3_2 = SubCategory(title: "Transportation", category: category3)
        var subCategory3_3 = SubCategory(title: "Accommodation", category: category3)

        category3.subCategories.append(contentsOf: [subCategory3_1, subCategory3_2, subCategory3_3])
        modelContext.insert(category3)
    }*/

}

private struct RowView: View {
    var category: Category
    
    var body: some View {
        HStack {
            Image(systemName: category.icon ?? "elipsis.circle")
                .foregroundStyle(Color(hex: category.color))
            Text(category.title)
                .foregroundStyle(Color(hex: category.color))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
    }

}

#Preview {
    TotalsView()
        .modelContainer(previewContainer)
}

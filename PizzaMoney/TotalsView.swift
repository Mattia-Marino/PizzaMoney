//
//  TotalsView.swift
//  PizzaMoney
//
//  Created by Armando on 03/02/25.
//

import SwiftUI
import SwiftData

struct TotalsView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var appSharedState : AppSharedState
   
    
    
    @Query(sort:\Transaction.title) var transaction:[Transaction]
    var body: some View {
        NavigationStack{
          
            ForEach(transaction){trans in
                Text(trans.subCategory?.category.title ?? "No SubCategory")
                Text(trans.subCategory?.title ?? "No SubCategory")
            }

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

#Preview {
    TotalsView()
        .modelContainer(for: Transaction.self, inMemory: true)
}

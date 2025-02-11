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
   
    
    
    @Query(sort:\Transaction.title) var categories:[Transaction]
    var body: some View {
        NavigationStack{
            ForEach(categories){category in
                List{
                    Text(category.category?.title ?? "")
                }
                .navigationBarTitle(category.title)
            }
        }

    }
  /*  func loadCategories(){
        
        let categories = [
            Category(
                title: "Food",
                icon: "fork.knife",
                color: "#FF6347",
                subCategories: [
                    SubCategory(title: "Fruits"),
                    SubCategory(title: "Vegetables"),
                    SubCategory(title: "Meat")
                ]
            ),
            Category(
                title: "Technology",
                icon: "desktopcomputer",
                color: "#1E90FF",
                subCategories: [
                    SubCategory(title: "Smartphones"),
                    SubCategory(title: "Laptops"),
                    SubCategory(title: "Wearables")
                ]
            ),
            Category(
                title: "Entertainment",
                icon: "film",
                color: "#FF69B4",
                subCategories: [
                    SubCategory(title: "Movies"),
                    SubCategory(title: "Music"),
                    SubCategory(title: "Video Games")
                ]
            ),
            Category(
                title: "Travel",
                icon: "airplane",
                color: "#32CD32",
                subCategories: [
                    SubCategory(title: "Destinations"),
                    SubCategory(title: "Transportation"),
                    SubCategory(title: "Accommodation")
                ]
            )
        ]
        
        for category in categories {
            modelContext.insert(category)
        }
    }*/
}

#Preview {
    TotalsView()
        .modelContainer(for: Transaction.self, inMemory: true)
}

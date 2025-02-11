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
   
    
    
    @Query(sort:\Category.title) var categories:[Category]
    var body: some View {
        NavigationStack{
            Button(action:{
                print("dsgsdfgd")
                loadCategories()
            }){
                Label("Load Categories", systemImage: "plus")
            }
        }

    }
    func loadCategories(){
        modelContext.insert(Category(
            title: "Food",
            icon: "fork.knife",
            color: "#FF6347"
            
        ))
        modelContext.insert(Category(
            title: "Technology",
            icon: "desktopcomputer",
            color: "#1E90FF"
           
        ))
        modelContext.insert(Category(
            title: "Entertainment",
            icon: "film",
            color: "#FF69B4"
        ))
        modelContext.insert(    Category(
            title: "Travel",
            icon: "airplane",
            color: "#32CD32"
        ))
    }
}

#Preview {
    TotalsView()
        .modelContainer(for: Transaction.self, inMemory: true)
}

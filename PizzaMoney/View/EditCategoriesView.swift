//
//  EditCategoriesView.swift
//  PizzaMoney
//
//  Created by san023 on 07/02/25.
//

import SwiftUI
import _SwiftData_SwiftUI
struct CategoryStruct: Identifiable {
    var id = UUID()
    var nome: String
    var img: String
    var color: Color
}

struct EditCategoriesView: View {
    var categories: [Category] = [
      
        Category(title: "Health", icon: "heart.fill", color: "#E74C3C",
        subCategories: [
            Category(title: "Mental health",color:"#000000"),
            Category(title: "Fitness",color:"#000000"),
            Category(title: "nutrition",color:"#000000"),
        ]),
        Category(title: "Food", icon: "cart.fill", color: "#FF5733",
        subCategories: [
            Category(title: "Restaurants",color:"#000000"),
            Category(title: "kitchen",color:"#000000"),
            Category(title: "Vegan food",color:"#000000"),
            ]),
        Category(title: "Investments", icon: "chart.line.uptrend.xyaxis", color: "#27AE60",
                 subCategories: [
                    Category(title: "Start up",color:"#000000"),
                    Category(title: "Real estate",color:"#000000"),
                    Category(title: "Cryptovalue",color:"#000000"),
                 ]),
        Category(title: "Utilities", icon: "bolt.fill", color: "#2980B9",
                 subCategories: [
                    Category(title: "Electricity",color:"#000000"),
                    Category(title: "Internet and phone",color:"#000000"),
                    Category(title: "Bills",color:"#000000"),
                    ]),
        Category(title: "Rent", icon: "house.fill", color: "#8E44AD",
                 subCategories: [
                    Category(title: "Car",color:"#000000"),
                    Category(title: "Public transports",color:"#000000"),
                    Category(title: "Scooter",color:"#000000"),
                    ]),
        Category(title: "Shopping", icon: "bag.fill", color: "#F39C12",
                 subCategories: [
                    Category(title: "Clothing and fashion",color:"#000000"),
                    Category(title: "Shopping online",color:"#000000"),
                    Category(title: "Computer",color:"#000000"),
                 ]),
        Category(title: "Travel", icon: "airplane", color: "#1ABC9C",
                 subCategories: [
                    Category(title: "Hotel",color:"#000000"),
                    Category(title: "Amsterdam 2025",color:"#000000"),
                    Category(title: "Travel experience",color:"#000000"),
                 ]),
        Category(title: "Entertainment", icon: "gamecontroller.fill", color: "#9B59B6",
                 subCategories: [
                    Category(title: "Film",color:"#000000"),
                    Category(title: "Netflix",color:"#000000"),
                    Category(title: "Music",color:"#000000"),
                 ]),
        Category(title: "Education", icon: "book.fill", color: "#2980B9",
                 subCategories: [
                    Category(title: "Online courses",color:"#000000"),
                    Category(title: "University",color:"#000000"),
                    Category(title: "Books",color:"#000000"),
                 ])
        
    ]
    
    var categoryMap: [String: Array<Category>] = ["Health": [
        Category(title: "Mental health",color:"#000000"),
        Category(title: "Fitness",color:"#000000"),
        Category(title: "nutrition",color:"#000000"),
    ],
                                                  "Education": []]
        
        @State var searchText: String = ""
    
    @State var catWithSub: Array<Category> = [];
    
        var body: some View {
        
            
            NavigationStack {
                ScrollView{
                    ForEach(searchResults) { category in
                        VStack {
                            HStack {
                                
                                Image(systemName: category.icon ?? "")
                                    .foregroundStyle(Color(hex: category.color))
                                Text(category.title)                            .foregroundStyle(Color(hex: category.color))
                                    
                                Spacer()
                                Button("Edit"){

                                }.foregroundStyle(.gray)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                
                            }
                            Divider()
                            VStack {
                                VStack(alignment: .leading){
                                    /*ForEach(category.subCategories ?? [], id:\.self) { subcategory in
                                    
                                            Text(subcategory.title)
                                            Divider()
                                        
                                       
                                    }*/
                                    ForEach(searchSubCat(categories: category.subCategories ?? []), id:\.self) { subcategory in
                                    
                                            Text(subcategory.title)
                                            Divider()
                                        
                                       
                                    }
                                    
                                }
                            }.frame(maxWidth: .infinity, alignment: .leading).padding().padding([.horizontal],20)
                        }.padding()
                    }
                }.searchable(text: $searchText)
                
            }
        }
    /*var searchResults: [Category]{
                if searchText.isEmpty{
                    return categories
                }else{
                 
                    return categories.filter {
                        $0.title.lowercased().contains(searchText.lowercased())
                    }
                    
                }
        }*/
    
    
    
    var searchResults: [Category]{
                if searchText.isEmpty{
                    return categories
                }else{
                 
                    return categories.filter {
                        filtSubCat(cats: $0.subCategories ?? [])
                    }
                }
        }
    func filtSubCat(cats: Array<Category>) -> Bool {
        if searchText.isEmpty {
            return true
        }
        return cats.filter { $0.title.lowercased().contains(searchText.lowercased())
        }.count > 0
    }

    func searchSubCat(categories: Array<Category>) -> Array<Category> {
        if searchText.isEmpty {
            //self.catWithSub = categories
            return categories
        }
        let subCats = categories.filter {
            $0.title.lowercased().contains(searchText.lowercased())
        }
        if subCats.count > 0 {
            let catFound = categories.filter { $0.title.lowercased()
                == searchText.lowercased()
            }
            //self.catWithSub.append(contentsOf: catFound)
        }
        return subCats
    }
    
    }


                
                
   

#Preview {
    EditCategoriesView()
}

//
//  CreateTransactionStepTwoView.swift
//  PizzaMoney
//
//  Created by san017 on 09/02/25.
//

import SwiftUI

struct CreateTransactionStepOneView: View {
    @EnvironmentObject var appSharedState : AppSharedState
    
    let categories = [
        Category(
            title: "Food",
            icon: "fork.knife",  // SF Symbol for a fork and knife
            color: "#FF6347",  // Tomato red
            subCategories: [
                Category(title: "Fruits", icon: "applelogo", color: "#000000"),  // SF Symbol for an apple logo
                Category(title: "Vegetables", icon: "leaf", color: "#000000"),  // SF Symbol for a leaf
                Category(title: "Meat", icon: "bone", color: "#000000")  // SF Symbol for a bone (meat)
            ]
        ),
        Category(
            title: "Technology",
            icon: "desktopcomputer",  // SF Symbol for a desktop computer
            color: "#1E90FF",  // Dodger blue
            subCategories: [
                Category(title: "Smartphones", icon: "iphone", color: "#000000"),  // SF Symbol for an iPhone
                Category(title: "Laptops", icon: "laptopcomputer", color: "#000000"),  // SF Symbol for a laptop
                Category(title: "Wearables", icon: "watch", color: "#000000")  // SF Symbol for a watch
            ]
        ),
        Category(
            title: "Entertainment",
            icon: "film",  // SF Symbol for a film reel
            color: "#FF69B4",  // Hot pink
            subCategories: [
                Category(title: "Movies", icon: "play.rectangle", color: "#000000"),  // SF Symbol for a play button (rectangle)
                Category(title: "Music", icon: "music.note", color: "#000000"),  // SF Symbol for a music note
                Category(title: "Video Games", icon: "gamecontroller", color: "#000000")  // SF Symbol for a game controller
            ]
        ),
        Category(
            title: "Travel",
            icon: "airplane",  // SF Symbol for an airplane
            color: "#32CD32",  // Lime green
            subCategories: [
                Category(title: "Destinations", icon: "location", color: "#000000"),  // SF Symbol for a location pin
                Category(title: "Transportation", icon: "car", color: "#000000"),  // SF Symbol for a car
                Category(title: "Accommodation", icon: "house", color: "#000000")  // SF Symbol for a house
            ]
        )
    ]
    
    
    @State private var selectedCategory: String = "Subscription"
    @State private var searchText: String = ""
    
    
    var body: some View {
        NavigationStack{
            VStack(){
                //Text(appSharedState.amount.description)
                //Text(appSharedState.data.formatted())
                //Text(appSharedState.bank.description)
                VStack{
                    HStack(spacing: 50){
                        Label("Title", systemImage: "")
                        TextField("Netplis", text: $appSharedState.title)
                        
                    }
                    Divider()
                    HStack(spacing: 50){
                        Label("Type", systemImage: "")
                        Spacer()
                        Picker(selection: $appSharedState.type, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                            Text("Expanse").tag(TransactionType.expense)
                            Text("Incoming").tag(TransactionType.income)
                        }
                    }
                    
                    Divider()
                }.padding([.horizontal],20).padding([.top],20)
                VStack{
                    Text("Category")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                      
                    //categories
                    ScrollView{
                        ForEach(searchResults) { category in
                            
                            HStack {
                                Image(systemName: category.icon ?? "")
                                    .foregroundStyle(Color(hex: category.color))
                                Text(category.title)                            .foregroundStyle(Color(hex: category.color))
                                
                                Spacer()
                            }.padding([.top],20)
                            
                            Divider()
                            VStack(alignment: .leading){
                                
                                ForEach(searchSubCat(categories: category.subCategories ?? []), id:\.self) { subcategory in
                                    
                                    VStack(alignment:.leading){
                                        HStack{
                                            Text(subcategory.title).foregroundStyle(Color(hex: subcategory.color))
                                            Spacer()
                                            
                                                if appSharedState.selectedSubCategory != nil && appSharedState.selectedSubCategory!.title == subcategory.title{
                                                    Image(systemName: "checkmark").foregroundStyle(.blue)
                                                }
                                            
                                        }.contentShape(Rectangle()).frame(maxWidth:.infinity,alignment: .leading )
                                            .onTapGesture {
                                                
                                                if appSharedState.selectedSubCategory != nil && appSharedState.selectedSubCategory!.title == subcategory.title{
                                                    return appSharedState.selectedSubCategory = nil
                                                }
                                               appSharedState.selectedSubCategory = subcategory
                                            }
                                        Divider()
                                    }.frame(maxWidth: .infinity, alignment: .leading).padding([.horizontal],30)
                                }
                            }
                        }
                    }.padding([.horizontal],20)
                }.padding([.top],20)
            }.searchable(text: $searchText).frame(maxHeight: .infinity, alignment:.leading)
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination:CreateTransactionStepTwoView()){
                            Text("Amount")
                            Image(systemName: "chevron.right")
                        }.disabled(appSharedState.title == "")
                    }
                    
                }.navigationTitle("Add transaction").navigationBarTitleDisplayMode(.inline)
        }
    }
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
    CreateTransactionStepOneView().environmentObject(AppSharedState())
}



//
//  EditCategoriesView.swift
//  PizzaMoney
//
//  Created by san023 on 07/02/25.
//

import SwiftUI
//import _SwiftData_SwiftUI

struct CategoryStruct: Identifiable {
    var id = UUID()
    var nome: String
    var img: String
    var color: Color
}

struct EditCategoriesView: View {
    
    @State var catWithSub: Array<Category> = []
    @State var categories: Array<Category> = createMock().categories
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView{
                ForEach(catWithSub) { category in
                    VStack {
                        HStack {
                            
                            Image(systemName: category.icon ?? "")
                                .foregroundStyle(Color(hex: category.color))
                            Text(category.title)                            .foregroundStyle(Color(hex: category.color))
                            
                            Spacer()
                            NavigationLink(destination: EditButtonView()){
                                Text("Edit")
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        
                        Divider()
                        VStack {
                            VStack(alignment: .leading){
                                ForEach(category.subCategories ?? [], id:\.self) { subcategory in
                                    
                                    Text(subcategory.title)
                                    Divider()
                                    
                                    
                                }
                                
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading).padding().padding([.horizontal],20)
                    }.padding()
                    
                }
            }
            .toolbar {
                ToolbarItem() {
                    NavigationLink(destination: EditCategory_Item()) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                
            }.navigationTitle("Edit transaction").navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
        }
    }
    
    var searchResults: [Category]{
        if searchText.isEmpty{
            return categories
        } else {
            //return categories
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
            self.catWithSub = categories
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
        .modelContainer(previewContainer)
}

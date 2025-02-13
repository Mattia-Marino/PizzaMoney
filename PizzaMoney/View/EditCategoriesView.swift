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
    @Environment(\.modelContext) private var modelContext
    
    @State var catWithSub: Array<Category> = []
    // @State var categories: Array<Category> = createMock().categories
    
    @Query(sort: [SortDescriptor(\Category.title)]) var categories: [Category]
    
    @State var searchText: String = ""
    
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
                            
                            NavigationLink(destination: EditButtonView()){
                                Text("Edit")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Divider()
                        VStack {
                            VStack(alignment: .leading){
                                ForEach(category.subCategories) { subcategory in
                                    Text(subcategory.title)
                                    Divider()
                                }
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading).padding().padding([.horizontal],20)
                    }.padding()
                }
            }.searchable(text: $searchText)
            .toolbar {
                ToolbarItem() {
                    NavigationLink(destination: EditCategory_Item()) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .navigationTitle("Edit categories")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    var searchResults: [Category] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter { category in
                category.title.lowercased().contains(searchText.lowercased()) ||
                category.subCategories.contains { subcategory in
                    subcategory.title.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
}


#Preview {
    EditCategoriesView()
        .modelContainer(previewContainer)
}

//
//  EditCategoriesView.swift
//  PizzaMoney
//
//  Created by san023 on 07/02/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct EditCategoriesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categoriesQuery: [Category]

    @State private var searchText: String = ""
    @State private var filteredCategories: [Category] = []
    
    // State variable for delete confirmation
    @State private var categoryToDelete: Category?
    @State private var isShowingDeleteAlert = false

    var body: some View {
        ScrollView {
            ForEach(filteredCategories) { category in
                VStack {
                    HStack {
                        Image(systemName: category.icon ?? "")
                            .foregroundStyle(Color(hex: category.color))
                        Text(category.title)
                            .foregroundStyle(Color(hex: category.color))

                        Spacer()
                        
                        // Delete button
                        Button(action: {
                            categoryToDelete = category
                            isShowingDeleteAlert = true
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .alert("Delete Category?", isPresented: $isShowingDeleteAlert, presenting: categoryToDelete) { category in
                            Button("Cancel", role: .cancel) { }
                            Button("Delete", role: .destructive) {
                                deleteCategory(category)
                            }
                        } message: { _ in
                            Text("This will delete the category and all its subcategories.")
                        }
                        

                        // Edit button
                        NavigationLink(destination: EditCategory_Item(existingCategory: category)) {
                            Text("Edit")
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .foregroundStyle(.gray)
                        .padding(.leading, 20)
                        
                    }
                    Divider()

                    VStack(alignment: .leading) {
                        ForEach(searchSubCat(subcategories: category.subCategories ?? []), id: \.self) { subcategory in
                            Text(subcategory.title)
                            Divider()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.horizontal, 20)
                }
                .padding()
            }
        }
        .searchable(text: $searchText)
        .toolbar {
            ToolbarItem {
                NavigationLink(destination: EditCategory_Item()) {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        .navigationTitle("Edit transaction")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: searchText) { _ in
            updateFilteredResults()
        }
        .onAppear {
            DispatchQueue.main.async {
                updateFilteredResults()
            }
        }
    }

    func updateFilteredResults() {
        if searchText.isEmpty {
            filteredCategories = categoriesQuery
        } else {
            filteredCategories = categoriesQuery.filter { category in
                filtSubCat(subcategories: category.subCategories)
            }
        }
    }

    func filtSubCat(subcategories: [SubCategory]) -> Bool {
        if searchText.isEmpty {
            return true
        }
        return subcategories.contains { subCat in
            subCat.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    func searchSubCat(subcategories: [SubCategory]) -> [SubCategory] {
        if searchText.isEmpty {
            return subcategories
        }
        return subcategories.filter { subCat in
            subCat.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    func deleteCategory(_ category: Category) {
        modelContext.delete(category)  // Remove category from SwiftData
        do {
            try modelContext.save()
            updateFilteredResults()  // Refresh the list
        } catch {
            print("Error deleting category: \(error)")
        }
    }
}

#Preview {
    EditCategoriesView()
        .modelContainer(previewContainer)
}

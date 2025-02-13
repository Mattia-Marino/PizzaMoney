//
//  EditCategory_Item.swift
//  PizzaMoney
//
//  Created by san023 on 10/02/25.
//

import SFSymbolsPicker
import SwiftUI

struct EditCategory_Item: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    // Optional category for editing
    var existingCategory: Category?

    @State private var categoryName: String = ""
    @State private var selectedIcon: String = "ellipsis"
    @State private var color: Color = .blue
    @State private var subCategories: [SubCategory] = []
    @State private var newItem: String = ""
    @State private var isPresented = false

    init(existingCategory: Category? = nil) {
        self.existingCategory = existingCategory
    }

    var body: some View {
        VStack {
            Divider()
            HStack {
                Text("Name")
                    .font(.headline)
                    .padding()

                TextField("Name of category", text: $categoryName)
                    .padding()
            }
            Divider()

            VStack {
                ColorPicker("Color", selection: $color)
                    .font(.headline)
                    .padding()
                Divider()

                HStack {
                    Text("Icon")
                        .font(.headline)
                        .padding()

                    Spacer()

                    Button(action: { isPresented.toggle() }) {
                        Image(systemName: selectedIcon)
                            .font(.system(size: 24))
                            .foregroundColor(color)
                    }
                    .padding(.trailing, 16)
                    .sheet(isPresented: $isPresented) {
                        SymbolsPicker(
                            selection: $selectedIcon,
                            title: "Pick a symbol",
                            autoDismiss: true
                        )
                    }
                }
                Divider()

                HStack {
                    Text("Add subcategories")
                        .foregroundColor(Color.black)
                        .padding(.leading)
                    Spacer()
                }
            }

            Spacer()

            VStack {
                HStack {
                    TextField("New subcategory", text: $newItem)
                        .padding()

                    Button(action: {
                        if !newItem.isEmpty {
                            let newSubCategory = SubCategory(title: newItem)
                            subCategories.append(newSubCategory)
                            newItem = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .padding()
                    }
                }
                Divider()
                    .padding()

                List {
                    ForEach(subCategories, id: \.id) { subCategory in
                        HStack {
                            Text(subCategory.title)
                            Spacer()
                            Button(action: {
                                if let index = subCategories.firstIndex(where: { $0.id == subCategory.id }) {
                                    subCategories.remove(at: index)
                                }
                            }) {
                                Label("", systemImage: "trash")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .padding()
        }
        .toolbar {
            Button("Save") {
                if let category = existingCategory {
                    // Update existing category
                    category.title = categoryName
                    category.icon = selectedIcon
                    category.color = color.toRGBString() ?? "#2E2E2E"

                    // Update subcategories
                    category.subCategories = subCategories
                } else {
                    // Create new category
                    let newCategory = Category(
                        title: categoryName,
                        icon: selectedIcon,
                        color: color.toRGBString() ?? "#2E2E2E",
                        subCategories: []
                    )
                    for subCategory in subCategories {
                        subCategory.category = newCategory
                    }
                    newCategory.subCategories = subCategories
                    modelContext.insert(newCategory)
                }

                do {
                    try modelContext.save()
                    dismiss() // Close the view
                } catch {
                    print("Error saving")
                }
            }
        }
        .navigationTitle(existingCategory == nil ? "New Category" : "Edit Category")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // If editing, populate the fields
            if let category = existingCategory {
                categoryName = category.title
                selectedIcon = category.icon ?? "ellipsis"
                color = Color(hex: category.color)
                subCategories = category.subCategories
            }
        }
    }
}

#Preview {
    EditCategory_Item()
}

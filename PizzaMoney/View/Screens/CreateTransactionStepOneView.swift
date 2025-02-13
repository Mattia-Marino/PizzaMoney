//
//  CreateTransactionStepTwoView.swift
//  PizzaMoney
//
//  Created by san017 on 09/02/25.
//



import SwiftUI
import SwiftData
struct CreateTransactionStepOneView: View {
    @EnvironmentObject var appSharedState : AppSharedState
    @Environment(\.modelContext) private var modelContext
    
    
    @State private var selectedCategory: String = "Subscription"
    @State private var searchText: String = ""
    
    @Query private var categories: [Category]
    @Binding var isSheetPresented: Bool
    @State private var isPagina2Presented = false
    
    var body: some View {
        NavigationStack{
            VStack(){
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
                    
                }
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
                            ForEach(searchSubCat(categories: category.subCategories), id:\.self) { subcategory in
                                SubCategoryRow(subcategory:subcategory)
                            }
                        }
                    }
                }.padding([.horizontal],20)
            }.padding([.top],20)
                .toolbar {
           
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination:CreateTransactionStepTwoView(isSheetPresented: $isSheetPresented)){
                        Text("Amount")
                        Image(systemName: "chevron.right")
                    }.disabled(appSharedState.title == "")
                }
           
            }
            .navigationTitle("Add transaction").navigationBarTitleDisplayMode(.inline)
           // .navigationBarItems(trailing: Button(action: {
           //     self.isPagina2Presented = true
           // }) {
           //     Text("Amount")
           //                  Image(systemName: "chevron.right")
           // }.disabled(appSharedState.title == ""))
           // .sheet(isPresented: self.$isPagina2Presented, content: { //CreateTransactionStepTwoView(isSheetPresented: $isSheetPresented)})
            
            
        }//.searchable(text: $searchText).frame(maxHeight: .infinity, alignment:.leading)
        
    }
    
    var searchResults: [Category]{
        if searchText.isEmpty{
            return categories
        }else{
            print(searchText)
            return categories.filter {
                filtSubCat(cats: $0.subCategories)
            }
        }
    }
    func filtSubCat(cats: Array<SubCategory>) -> Bool {
        if searchText.isEmpty {
            return true
        }
        return cats.filter { $0.title.lowercased().contains(searchText.lowercased())
        }.count > 0
    }
    
    func searchSubCat(categories: Array<SubCategory>) -> Array<SubCategory> {
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


struct SubCategoryRow:View{
    @EnvironmentObject var appSharedState : AppSharedState
    var subcategory:SubCategory!
    
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text(subcategory.title)
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

#Preview {
    CreateTransactionStepOneView(isSheetPresented: .constant(true)).environmentObject(AppSharedState())
}

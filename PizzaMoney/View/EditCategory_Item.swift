//
//  EditCategory_Item.swift
//  PizzaMoney
//
//  Created by san023 on 10/02/25.
//

import SwiftUI
import SFSymbolsPicker

struct EditCategory_Item: View {
    @Environment(\.modelContext) private var modelContext
    @State private var newItem: String = ""
    @State private var items: [String] = []  // Lista per memorizzare gli elementi aggiunti
    
    @State private var categoryName: String = ""
    @State private var selectedIcon: String = "ellipsis"
    
    @State private var icon = "star.fill"
    @State private var isPresented = false
    @State private var color = Color.blue
    
    var body: some View {
        NavigationStack {
            
            
            VStack{
                Divider()
                HStack{
                    Text("Name")
                        .font(.headline)
                        .padding()
                    
                    TextField("Name of category", text: $categoryName)
                        .padding()
                    
                    
                    
                }
                Divider()
                
                
                VStack{
                    
                    ColorPicker("Color", selection: $color)
                        .font(.headline)
                        .padding()
                    Divider()
                    
                    
                    
                    VStack{
                        
                        HStack{
                            Text("Icon")
                                .font(.headline)
                                .padding()
                            
                            Spacer()
                            
                            Button(action: {
                                isPresented.toggle()
                            }) {
                                Image(systemName: selectedIcon) // SF Symbol
                                    .font(.system(size: 24)) // Adjust size
                                    .foregroundColor(color) // TODO: cambia colore con quello selezionato
                            }
                            .padding(.trailing, 16)
                            .sheet(isPresented: $isPresented, content: {
                                SymbolsPicker(selection: $selectedIcon, title: "Pick a symbol", autoDismiss: true)
                            })
                            
                            
                        }
                        
                        Divider()
                        HStack{
                            Text("Add subcategories")
                                .foregroundColor(Color.black)
                                .padding(.leading)
                            Spacer()
                            
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                }
                Spacer()
                
                VStack {
                               // Campo di testo per inserire un nuovo elemento
                               HStack {
                                   TextField("New subcategory", text: $newItem)
                                       .padding()
                                       
                                   Button(action: {
                                       // Aggiungi l'elemento alla lista solo se non è vuoto
                                       if !newItem.isEmpty {
                                           items.append(newItem)
                                           newItem = ""  // Reset del campo di testo dopo aver aggiunto l'elemento
                                       }
                                   }) {
                                       Text("+")
                                           .frame(width: 35, height: 35)
                                           .foregroundColor(.blue)
                                           .cornerRadius(100)
                                   }
                               }
                    Divider()
                               .padding()

                               // Lista di elementi aggiunti dall'utente
                    List {
                        ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                            HStack {
                                Text(item)
                                Spacer()
                                Button(action: {
                                    items.remove(at: index)
                                    
                                }) {
                                    Label("", systemImage: "trash")
                                }
                            }
                        }
                    }
                               
                           }
                           .padding()
                
            }.toolbar{
                Button("Save"){
                    let newCategoria = Category(title: categoryName , color: "", subCategories: [])
                    for item in items{
                        newCategoria.subCategories?.append(Category(title: item, color: ""))
                    }
                    modelContext.insert(newCategoria)
                    do {
                        try modelContext.save()
                    } catch {
                        print("Errore in salva")
                    }
                }
            }.navigationTitle("Edit Category").navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    EditCategory_Item()
    
}

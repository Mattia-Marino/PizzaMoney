//
//  EditCategory_Item.swift
//  PizzaMoney
//
//  Created by san023 on 10/02/25.
//

import SwiftUI
import SFSymbolsPicker

struct EditCategory_Item: View {
    @State private var Userimput: String = ""
    @State private var selectedIcon: String = "ellipsis"
    
    @State private var icon = "star.fill"
    @State private var isPresented = false
    @State private var color = Color.blue
    
    var body: some View {
        VStack{
            Text("Name")
                .font(.headline)
            
            TextField("Name of category", text: $Userimput)
                .padding()
            
            VStack{
                
                ColorPicker("Color", selection: $color)
                    .font(.headline)
                    .padding()
                

                VStack{
                    
                    HStack{
                        Text("Icon")
                            .font(.headline)
                            .padding(.leading, 10)
                        
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
                    
                    
                    
                    /*HStack{
                        ForEach(Icons, id: \.self){ icon in
                            Button(action: {
                                selectedIcon = icon
                            }){
                                Image(systemName: icon)
                                    .font(.system(size: 30))
                                    .padding()
                                    .foregroundColor(selectedIcon == icon ? .blue : .black)
                                    .background()
                                Circle()
                                    .stroke(selectedIcon == icon ? Color.blue : Color.black, lineWidth: 3)
                            }
                                
                        }
                    }*/
                        
                        
                }
                
            }
            
                
        }
    }
}

#Preview {
    EditCategory_Item()
}

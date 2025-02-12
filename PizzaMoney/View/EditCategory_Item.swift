//
//  EditCategory_Item.swift
//  PizzaMoney
//
//  Created by san023 on 10/02/25.
//

import SwiftUI

struct EditCategory_Item: View {
@State private var Userimput: String = ""
@State private var selectedIcon: String = ""
    var body: some View {
        VStack{
            Text("Name")
                .font(.headline)
            
            TextField("Name of category", text: $Userimput)
                .padding()
            
            VStack{
                
                ColorPicker("Color", selection: .constant(.blue))
                    .font(.headline)
                    .padding()
                
                VStack{
                    Text("Icon")
                        .font(.headline)
                    
                    let Icons = [ "moon", "sun", "moon.stars", "sun.max", "moon.min", "sun.min", "moon.stars.fill", "sun.fill" ]
                    
                    Image(systemName: selectedIcon)
                        .font(.system(size: 32))
                        .padding()
                    
                    HStack{
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
                    }
                        
                        
                }
                
            }
            
                
        }
    }
}

#Preview {
    EditCategory_Item()
}

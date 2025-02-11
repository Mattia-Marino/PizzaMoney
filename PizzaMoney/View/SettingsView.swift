//
//  SettingsView.swift
//  PizzaMoney
//
//  Created by san004 on 07/02/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            
            VStack{
                HStack{
                    Text("Appearance")
                        .font(.system(size: 25, weight:       .bold))
                        .fontWeight(.regular)
                        .padding(/*@START_MENU_TOKEN@*/.leading, 10.0)
                    .foregroundStyle(Color.gray);               Spacer()}
                
                HStack{
                    Text("Theme")
                        .font(.system(size: 20, weight: .regular))
                        .padding(.leading, 30.0)
                    
                    Spacer()
                    
                    Picker(selection: .constant(1), label: Text("Picker")
                        
                        )
                    {
                        Text("System").tag(1)
                        /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                        
                        
                    }.padding(.trailing, 10.0)
                    
                }
                
                Divider()
                    .frame(width: 350.0)
                
                HStack{
                    
                    Text("Tools")
                        .font(.system(size: 25, weight:       .bold))
                        .fontWeight(.regular)
                        .padding(.leading, 14.0)
                        .foregroundStyle(Color.gray);
                    
                    Spacer()
                    
                }
                
                HStack{
                    Text("Edit categories")
                        .font(.system(size: 20, weight: .regular))
                        .padding(.leading, 30.0);                Spacer()
                    Button(action: {
                                    
                                }) {
                                    Image(systemName: "pencil")
                                    .foregroundStyle(.blue)
                                    .font(.title)              .padding(.top, 10.0)      }
                                .padding(.leading, 175.0)

                        Spacer()
                            
                    }
                }
            Divider()
                .frame(width: 350.0)
                Spacer()
                
                .navigationBarTitle("Settings", displayMode:.inline)
            }
        }
    }
    
    
#Preview {
    SettingsView()
}


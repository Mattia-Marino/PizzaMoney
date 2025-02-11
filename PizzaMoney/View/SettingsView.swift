//
//  SettingsView.swift
//  PizzaMoney
//
//  Created by san004 on 07/02/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("theme") private var theme = ThemeSetting.system
    
    @State private var selectedValue: Int? = 0
    
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
                    
                    Picker(selection: $selectedValue, label: Text("Picker")
                        
                        )
                    {
                        
                        ForEach(ThemeSetting.allCases, id: \.rawValue) { setting in
                            Text(setting.name).tag(setting.rawValue)
                        }
                        
                        
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
                                .padding(.leading, 125.0)

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


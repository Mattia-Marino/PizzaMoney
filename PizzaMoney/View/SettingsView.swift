//
//  SettingsView.swift
//  PizzaMoney
//
//  Created by san004 on 07/02/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("theme") private var theme = ThemeSetting.system
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Appearance")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(Color.gray)
                        .padding(.leading, 10)
                    Spacer()
                }
                
                HStack {
                    Text("Theme")
                        .font(.system(size: 20, weight: .regular))
                        .padding(.leading, 30)
                    
                    Spacer()
                    
                    Picker(selection: $theme, label: Text("Picker")) {
                        ForEach(ThemeSetting.allCases, id: \.self) { setting in
                            Text(setting.name).tag(setting)
                        }
                    }
                    .pickerStyle(MenuPickerStyle()) // Optional: Better UI
                    
                    .padding(.trailing, 10)
                }
                
                Divider().frame(width: 350)
                
                HStack {
                    Text("Tools")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(Color.gray)
                        .padding(.leading, 14)
                    Spacer()
                }
                
                HStack {
                    Text("Edit categories")
                        .font(.system(size: 20, weight: .regular))
                        .padding(.leading, 30)
                    Spacer()
                    Button(action: {
                        // Action for editing categories
                    }) {
                        Image(systemName: "pencil")
                            .foregroundStyle(.blue)
                            .font(.title)
                            .padding(.top, 10)
                    }
                    .padding(.leading, 125)
                    
                    Spacer()
                }
                
                Divider().frame(width: 350)
                Spacer()
            }
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

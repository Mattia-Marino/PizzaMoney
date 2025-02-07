//
//  SettingsView.swift
//  PizzaMoney
//
//  Created by san004 on 07/02/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .font(.system(size: 30, weight: .bold));        Spacer()
        VStack{
            HStack{
                Text("Appearance")
                    .font(.system(size: 25, weight:       .bold))
                    .fontWeight(.regular)
                    .padding(/*@START_MENU_TOKEN@*/)
                .foregroundStyle(Color.gray);               Spacer()}
            Text("Theme")
                .font(.system(size: 20, weight: .regular))
                .padding(.top, -19.0)
            
            
            Spacer()
        }
    }
}
            
        

#Preview {
    SettingsView()
}

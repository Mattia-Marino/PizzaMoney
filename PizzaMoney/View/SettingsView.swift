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
            .font(.system(size: 30, weight: .bold))
            .fontWeight(.semibold);        Spacer()
        VStack{
            HStack{
                Text("Appearance")
                    .font(.system(size: 25, weight:       .bold))
                    .fontWeight(.regular)
                    .padding(/*@START_MENU_TOKEN@*/.leading, 10.0)
                .foregroundStyle(Color.gray);               Spacer()}
            Text("Theme")
                .font(.system(size: 20, weight: .regular))
                .padding(.top, -5.0)
                .padding(.trailing, 275.0)
            Divider()
                .frame(width: 350.0)
            Picker(selection: .constant(1), label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                Text("System").tag(1)
                /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                
            }
            .padding(.top, -48.0)
            .padding(.leading, 250.0)

            Spacer()
        }
    }
}
            
        

#Preview {
    SettingsView()
}

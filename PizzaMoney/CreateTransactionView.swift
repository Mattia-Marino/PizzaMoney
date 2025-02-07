//
//  CreateTransactionView.swift
//  PizzaMoney
//
//  Created by san017 on 07/02/25.
//

import SwiftUI

struct CreateTransactionView: View {
    
    let banks = ["Bank A", "Bank B", "Bank C"]
    @State var selected = "Bank A"
    @State var amount:Float = 0
    var body: some View {
        NavigationStack{
            VStack{
                
                
                CarouselView(banks: banks, selected: $selected)
                Spacer()
                TextField("Enter your score", value: $amount, format: .number)
                    .textFieldStyle(.plain)
                         
                          .padding()
                Spacer()


            }.padding().toolbar {
                /*NavigationLink(destination:EmptyView()){
                  HStack{
                    Text("Save")
                    Image(systemName: "arrow")
                  }
                }*/
            }.navigationTitle("Add transaction").navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CreateTransactionView()
}

//
//  CreateTransactionView.swift
//  PizzaMoney
//
//  Created by san017 on 07/02/25.
//

import SwiftUI


struct CreateTransactionStepTwoView: View {
    
    var banks = ["Contesa San Paolo", "Banca Inulia", "BananaRepublic"]
    
    @EnvironmentObject var appSharedState : AppSharedState
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var date = Date()
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        
        let currentDate = Date()
        
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        
        let hours = calendar.component(.hour, from: currentDate)
        let minutes = calendar.component(.minute, from: currentDate)
        
        
        let startComponents = DateComponents(year:year, month: month, day: day)
        let endComponents = DateComponents(year:2029, month: month, day: day, hour: hours, minute: minutes, second: 00)
        return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
    }()
    
    
    var body: some View {
        
        NavigationStack{
            VStack{
                
                CarouselView(banks: banks, selected: $appSharedState.bank)
                
                HStack{
                    
                    TextField("", value: $appSharedState.amount, format: .currency(code: "EUR"))
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.plain)
                        .font(.custom("AvenirNext-Medium", size: 55))
                        .padding()
                        .keyboardType(.decimalPad)
                    
                }.frame(height: 300)
                
                Spacer()
                
                
                DatePicker(
                    selection: $appSharedState.data,
                    displayedComponents: [.date, .hourAndMinute]
                ){
                    //Text(date.ISO8601Format())
                    
                }.foregroundColor(Color("ChartColor"))
                    .datePickerStyle(CompactDatePickerStyle())
                    .clipped()
                    .labelsHidden()
                
                Spacer()
                //buttons
                HStack{
                    Button(action:{
                        
                        //return to transactions page
                        
                        dismiss()
                    }){
                        Label("Cancel", systemImage: "arrow.up.circle")
                    }
                    .padding(10)
                    .padding([.horizontal],30)
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    
                        NavigationLink(destination: EmptyView()){
                            Button(action:{
                                let newTransaction = Transaction(
                                    title: appSharedState.title,
                                    date: appSharedState.data,
                                    amount: appSharedState.amount,
                                    transactionType: appSharedState.type,
                                    category: appSharedState.selectedSubCategory
                                )
                                modelContext.insert(newTransaction)
                                
                                //reset appSharedState after insert
                                appSharedState.bank = "Contesa San Paolo"
                                appSharedState.title = ""
                                appSharedState.data = Date.now
                                appSharedState.amount = 0.0
                                appSharedState.selectedSubCategory = nil
                                appSharedState.type = TransactionType.expense
                                
                                
                            }){
                                
                                Label("Save", systemImage: "arrow.up.circle")
                                    .padding(10)
                                    .padding([.horizontal],30)
                                    .background(Color.blue)
                                    .foregroundStyle(.white)
                                    .clipShape(Capsule())
                            }
                        }
                }
                
            }.padding().toolbar {
                
            }.navigationTitle("Add transaction").navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CreateTransactionStepTwoView().environmentObject(AppSharedState())
}

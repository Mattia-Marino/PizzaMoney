//
//  CreateTransactionView.swift
//  PizzaMoney
//
//  Created by san017 on 07/02/25.
//

import SwiftUI
import _SwiftData_SwiftUI


struct CreateTransactionStepTwoView: View {
    @Query(sort: [SortDescriptor(\Wallet.name)]) var banks: [Wallet]

    //var banks = ["Contesa San Paolo", "Banca Inulia", "BananaRepublic"]
    
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
                
               // CarouselView(wallets: appSharedState.wallets, selected: $appSharedState.selectedWallet)
                CarouselView(wallets: banks, selected: $appSharedState.selectedWallet)
                
                HStack{
                    
                    TextField("", value: $appSharedState.amount, format: .currency(code: "EUR"))
                        .padding([.top],200)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.plain)
                        .font(.custom("AvenirNext-Medium", size: 55))
                        .padding()
                        .keyboardType(.decimalPad)

                    
                }.frame(height: 200)
                
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
            }.padding().toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: TransactionsListView()){
                        Button(action:{
                            let newTransaction = Transaction(
                                title: appSharedState.title,
                                date: appSharedState.data,
                                amount: appSharedState.amount,
                                transactionType: appSharedState.type,
                                subCategory: appSharedState.selectedSubCategory
                            )
                            appSharedState.selectedWallet?.transactions.append(newTransaction)
                            
                            modelContext.insert(appSharedState.selectedWallet!)
                            
                            //reset appSharedState after insert
                            appSharedState.title = ""
                            appSharedState.data = Date.now
                            appSharedState.amount = 0.0
                            appSharedState.selectedSubCategory = nil
                            appSharedState.type = TransactionType.expense
                            
                            
                        }){
                            Text("Save")
                        }
                    }
                }
            }.navigationTitle("Add transaction").navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CreateTransactionStepTwoView().environmentObject(AppSharedState())
}

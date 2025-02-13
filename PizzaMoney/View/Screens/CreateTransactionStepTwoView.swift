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

    @EnvironmentObject var appSharedState: AppSharedState
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Binding var isSheetPresented: Bool

    @State private var date = Date()
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current

        let currentDate = Date()

        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)

        let hours = calendar.component(.hour, from: currentDate)
        let minutes = calendar.component(.minute, from: currentDate)

        let startComponents = DateComponents(year: year, month: month, day: day)
        let endComponents = DateComponents(
            year: 2029, month: month, day: day, hour: hours, minute: minutes,
            second: 00)
        return calendar.date(from: startComponents)!...calendar.date(
            from: endComponents)!
    }()

    var body: some View {
        
        var padding =
            if appSharedState.amount / 10 == 0 { 130 }
            else if appSharedState.amount / 10 > 0 && appSharedState.amount / 10 < 10 { 120 }
            else if appSharedState.amount / 10 >= 10 { 110 }
        else {130}

        VStack {

            // CarouselView(wallets: appSharedState.wallets, selected: $appSharedState.selectedWallet)
            CarouselView(
                wallets: banks, selected: $appSharedState.selectedWallet)

            HStack {
                Spacer()

                TextField(
                    "", value: $appSharedState.amount, format: .number
                )
                .multilineTextAlignment(.trailing)
                .textFieldStyle(.plain)
                .font(.custom("AvenirNext-Medium", size: 55))
                .keyboardType(.decimalPad)
                .layoutPriority(1)  // Ensures the TextField gets priority in resizing
                .frame(minWidth: 50, maxWidth: .infinity)

                Text("€")  // Display the currency symbol separately
                    .font(.custom("AvenirNext-Medium", size: 55))
                    .padding(.trailing, CGFloat(130 - (appSharedState.amount.formatted().count * 10)))
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .frame(height: 200)

            Spacer()

            DatePicker(
                selection: $appSharedState.data,
                displayedComponents: [.date, .hourAndMinute]
            ) {
                //Text(date.ISO8601Format())

            }.foregroundColor(Color("ChartColor"))
                .datePickerStyle(CompactDatePickerStyle())
                .clipped()
                .labelsHidden()

            Spacer()
        }.padding().toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: TransactionsListView()) {
                    Button(action: {
                        let newTransaction = Transaction(
                            title: appSharedState.title,
                            date: appSharedState.data,
                            amount: appSharedState.amount,
                            transactionType: appSharedState.type,
                            subCategory: appSharedState.selectedSubCategory
                        )
                        appSharedState.selectedWallet?.transactions.append(
                            newTransaction)

                        do {
                            try modelContext.save()
                            dismiss()  // Close the view
                        } catch {
                            print("Error saving")
                        }

                        isSheetPresented = false

                        //reset appSharedState after insert
                        appSharedState.title = ""
                        appSharedState.data = Date.now
                        appSharedState.amount = 0.0
                        appSharedState.selectedSubCategory = nil
                        appSharedState.type = TransactionType.expense

                    }) {
                        Text("Save")
                    }
                }
            }
        }
        .navigationTitle("Add transaction")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CreateTransactionStepTwoView(isSheetPresented: .constant(true))
        .environmentObject(AppSharedState())
}

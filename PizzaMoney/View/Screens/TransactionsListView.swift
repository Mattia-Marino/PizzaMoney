import SwiftUI
import SwiftData
import Charts

struct TransactionsListView: View {
    
    @AppStorage("filter_startDate") var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
    
    //@AppStorage("filter_endDate") var endDate: Date = Date()
    @AppStorage("filter_endDate") var endDate: Date = Calendar.current.date(byAdding: .day, value: +1, to: Date())!
    
    @Query(sort: [SortDescriptor(\Wallet.name)]) var wallets: [Wallet]
    
    @State var currentWallet: Wallet?
    @State private var isSheetPresented = false
    
    var filteredTransactions: [Transaction] {
        guard let currentWallet = currentWallet else { return [] }
        return currentWallet.transactions
            .filter { $0.date >= startDate && $0.date <= endDate }
    }
   
    var body: some View {
        
        NavigationStack {
            
            TransactionsListContent()
            
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                self.isSheetPresented = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
            })
            .sheet(isPresented: self.$isSheetPresented, content: { CreateTransactionStepOneView(isSheetPresented: $isSheetPresented)})
            
           // .toolbar {
           //     ToolbarItem(placement: .topBarTrailing) {
           //         Button(action: {
           //             // Action for editing categories
           //         }) {
           //             NavigationLink(destination: CreateTransactionStepOneView()){
           //                 Image(systemName: "plus")
           //             }
           //         }
           //     }
           // }
            
        }
        
    }
    
}



#Preview {
    TransactionsListView()
        .modelContainer(previewContainer)
}

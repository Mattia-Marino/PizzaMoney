import SwiftUI
import SwiftData

struct ContentView: View {
    /* Per ora lo teniamo il codice generato da XCode,
     * ché magari ci torna utile dopo */
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
    

    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
        TabView {
            Tab("Totals", systemImage: "chart.pie"){
                TotalsView()
            }
            Tab("Accounts", systemImage: "wallet.bifold"){
                
            }
            Tab("Transactions", systemImage: "list.bullet"){
                
            }
            Tab("Settings", systemImage: "gearshape"){
                
            }
        }
    }

    
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}


let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Wallet.self,
                                           configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        Task { @MainActor in
            
            let context = container.mainContext
            
            let wallets = createMockWallets()
            
            for wallet in wallets {
                print(wallet.name)
                context.insert(wallet)
            }
            
        }
        
        return container
    } catch {
        fatalError("Failed to create container: \(error.localizedDescription)")
    }
}()

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}

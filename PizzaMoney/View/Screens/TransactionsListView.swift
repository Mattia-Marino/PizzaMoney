import SwiftUI
import SwiftData
import Charts

struct TransactionsListView: View {
    
    var body: some View {
        
        NavigationStack {
            
            TransactionsListContent()
            
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Plus button was tapped")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
            
        }
        
    }
    
}



#Preview {
    TransactionsListView()
        .modelContainer(previewContainer)
}

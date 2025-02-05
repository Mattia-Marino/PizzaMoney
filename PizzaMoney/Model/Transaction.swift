import Foundation
import SwiftData

@Model
final class Transaction {
    var id = UUID()
    var timestamp: Date = Date()
    var title: String
    /* SwiftData non gestisce benissimo l'ereditarietà.
     * La categoria può essere sia principale che sottocategoria. */
    var categoryID: UUID?
    var transactionType: TransactionType = TransactionType.expense
    var amount: Double
    
    init(title: String) {
        self.title = title
    }
}

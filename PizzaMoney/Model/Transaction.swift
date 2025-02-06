import Foundation
import SwiftData

@Model
final class Transaction {
    var id = UUID()
    var date: Date
    var title: String
    /* SwiftData non gestisce l'ereditarietà.
     * La categoria può essere sia principale che sottocategoria. */
    var category: Category? = nil
    var transactionType: TransactionType
    var amount: Double
    
    init(title: String,
         date: Date,
         amount: Double,
         transactionType: TransactionType,
         category: Category? = nil) {
        self.title = title
        self.date = date
        self.category = category
        self.transactionType = transactionType
        self.amount = amount
    }
}

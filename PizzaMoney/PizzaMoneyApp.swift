import SwiftUI
import SwiftData

class AppSharedState: ObservableObject {
    @Published var bank = "Contesa San Paolo"
    @Published var title : String = ""
    @Published var data : Date = Date.now
    @Published var amount = 0.0
    @Published var selectedSubCategory: SubCategory? = nil
    @Published var type: TransactionType = TransactionType.expense
    @Published var wallets :[Wallet] = createMock().wallets
    @Published var selectedWallet : Wallet? = nil
}


@main
struct PizzaMoneyApp: App {
    
    @AppStorage("theme") private var theme = ThemeSetting.system
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Transaction.self,
            Category.self,
            Wallet.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject var appSharedState: AppSharedState = AppSharedState()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView() // Start with splash screen
                .applyTheme(theme)
                .modelContainer(sharedModelContainer)
                .environmentObject(appSharedState)
        }
    }
}

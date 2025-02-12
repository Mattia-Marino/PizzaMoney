import SwiftUI
import SwiftData

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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .applyTheme(theme)
        }
        .modelContainer(sharedModelContainer)
    }
}

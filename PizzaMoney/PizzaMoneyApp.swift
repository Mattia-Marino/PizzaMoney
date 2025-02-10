import SwiftUI
import SwiftData

class AppSharedState: ObservableObject {
    @Published var bank = "Contesa San Paolo"
    @Published var title = ""
    @Published var data : Date = Date.now
    @Published var amount = 0.0
    @Published var selectedSubCategory: String = ""
    @Published var type = "expanse"
}


@main
struct PizzaMoneyApp: App {

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
    

    @StateObject var appSharedState : AppSharedState = AppSharedState()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(appSharedState)
    }
}


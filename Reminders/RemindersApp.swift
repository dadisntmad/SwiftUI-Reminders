import SwiftUI

@main
struct RemindersApp: App {
    @State private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     coreDataStack.container.viewContext
                )
        }
    }
}

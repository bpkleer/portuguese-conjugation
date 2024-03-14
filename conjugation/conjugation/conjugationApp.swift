import SwiftUI

@main
struct conjugationApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserSettings())  // assign environment
        }
    }
}

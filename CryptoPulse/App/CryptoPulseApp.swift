import SwiftUI
import SwiftData

@main
struct CryptoPulseApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    @State
    private var container = DIContainer(
        persistence: PersistenceController()
    )

    var body: some Scene {

        WindowGroup {
            RootView()
                .environment(container)
        }
        .modelContainer(
            container.appDependencies.persistence.container
        )
    }
}

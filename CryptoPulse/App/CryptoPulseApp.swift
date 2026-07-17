//
//  CryptoPulseApp.swift
//  CryptoPulse
//

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
            container.app.persistence.container
        )
    }
}
////
////  CryptoPulseApp.swift
////  CryptoPulse
////
////  Created by Labhesh Dudi on 15/07/26.
////
//
//import SwiftUI
//import SwiftData
//
//@main
//struct CryptoPulseApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .modelContainer(sharedModelContainer)
//    }
//}

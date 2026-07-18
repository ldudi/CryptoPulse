import UIKit
import OSLog

final class AppDelegate: NSObject, UIApplicationDelegate {

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "CryptoPulse",
        category: "Application"
    )

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {

        logger.info("🚀 Application Launched")

        configureAppearance()
        configureServices()

        return true
    }

    private func configureAppearance() {

        UINavigationBar.appearance().prefersLargeTitles = true
    }

    private func configureServices() {

        logger.info("Configuring application services")
    }
}

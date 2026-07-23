import Foundation

struct AppConfiguration {
    
    let environment: AppEnvironment
    
    var apiBaseURL: URL {
        environment.baseURL
    }
    
    var appName: String {
        "CryptoPulse"
    }
    
    var apiVersion: String {
        "v3"
    }
    
    var requestTimeout: TimeInterval {
        30
    }
    
    var enablesLogging: Bool {
        environment.isDebug
    }
    
    var enablesAnalytics: Bool {
        environment.isProduction
    }
    
    var enablesCrashReporting: Bool {
        environment.isProduction
    }

    static let live = AppConfiguration(
        environment: .current
    )
}

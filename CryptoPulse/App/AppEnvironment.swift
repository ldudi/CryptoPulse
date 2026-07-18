import Foundation

enum AppEnvironment: String, CaseIterable {

    case development
    case staging
    case production

    static var current: AppEnvironment {

        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }

    var displayName: String {
        switch self {
        case .development:
            return "Development"

        case .staging:
            return "Staging"

        case .production:
            return "Production"
        }
    }

    var baseURL: URL {

        switch self {

        case .development,
             .staging,
             .production:

            return URL(string: "https://api.coingecko.com/api/v3")!
        }
    }

    var isProduction: Bool {
        self == .production
    }

    var isDebug: Bool {
        self != .production
    }
}

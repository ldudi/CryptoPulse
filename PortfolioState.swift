import Foundation

/// Holds the UI state for the portfolio screen.
struct PortfolioState {
    enum Status {
        case idle
        case loading
        case loaded
        case empty
        case error(Error)
    }

    var assets: [PortfolioAsset] = []
    var analytics: PortfolioAnalytics? = nil
    var status: Status = .idle
}

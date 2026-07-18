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
    var totalValue: Double = 0.0
    var assetCount: Int = 0
    var totalCoins: Double = 0.0
    var largestHolding: PortfolioAsset? = nil

    var status: Status = .idle
}

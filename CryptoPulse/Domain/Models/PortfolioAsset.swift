import Foundation

/// A presentation‑level model that combines a stored holding with live market data.
struct PortfolioAsset: Identifiable {
    // MARK: - Identification

    /// Unique identifier for SwiftUI lists.  Uses the underlying coin ID.
    var id: String { coinID }

    // MARK: - Holding information

    let coinID: String
    let symbol: String
    let name: String
    let imageURL: URL?
    let quantity: Double

    // MARK: - Market data

    /// Current price in the selected currency (USD by default).
    let currentPrice: Double

    /// Value of this holding (`quantity * currentPrice`).
    let currentValue: Double

    /// 24‑hour percentage change.
    let priceChange24H: Double?

    /// Rank by market cap.
    let marketCapRank: Int?

    // MARK: - Analytics

    /// Allocation percentage of this asset in the portfolio.
    let allocationPercentage: Double

    // MARK: - Initializer

    init(holding: PortfolioHolding, coin: Coin, allocationPercentage: Double) {
        self.coinID = holding.coinID
        self.symbol = holding.symbol
        self.name = holding.name
        self.imageURL = holding.imageURL
        self.quantity = holding.quantity

        self.currentPrice = coin.currentPrice
        self.currentValue = coin.currentPrice * holding.quantity
        self.priceChange24H = coin.priceChange24H
        self.marketCapRank = coin.marketCapRank
        self.allocationPercentage = allocationPercentage
    }
}

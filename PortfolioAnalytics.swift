import Foundation

/// Represents analytics for a portfolio.
struct PortfolioAnalytics {
    let totalValue: Double
    let assetCount: Int
    let totalCoins: Double
    let largestHolding: PortfolioAsset?
    let largestHoldingPercentage: Double
}

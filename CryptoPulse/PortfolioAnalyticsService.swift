import Foundation

/// Service responsible for calculating portfolio analytics.
final class PortfolioAnalyticsService {
    
    /// Calculates portfolio analytics from a list of assets.
    func calculateAnalytics(from assets: [PortfolioAsset]) -> PortfolioAnalytics {
        guard !assets.isEmpty else {
            return PortfolioAnalytics(
                totalValue: 0.0,
                assetCount: 0,
                totalCoins: 0.0,
                largestHolding: nil,
                largestHoldingPercentage: 0.0
            )
        }
        
        let totalValue = assets.reduce(0.0) { $0 + $1.currentValue }
        let assetCount = assets.count
        let totalCoins = assets.reduce(0.0) { $0 + $1.quantity }
        
        let largestHolding = assets.max(by: { ($0.currentValue ?? 0.0) < ($1.currentValue ?? 0.0) })
        let largestHoldingPercentage = totalValue > 0 ? (largestHolding?.currentValue ?? 0.0) / totalValue * 100 : 0.0
        
        return PortfolioAnalytics(
            totalValue: totalValue,
            assetCount: assetCount,
            totalCoins: totalCoins,
            largestHolding: largestHolding,
            largestHoldingPercentage: largestHoldingPercentage
        )
    }
    
    /// Calculates allocation percentage for a single asset.
    func calculateAllocationPercentage(for asset: PortfolioAsset, totalPortfolioValue: Double) -> Double {
        guard totalPortfolioValue > 0 else { return 0.0 }
        return (asset.currentValue / totalPortfolioValue) * 100
    }
}

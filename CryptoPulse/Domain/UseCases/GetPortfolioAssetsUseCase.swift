import Foundation

/// Fetches portfolio holdings and enriches them with live market data.
///
/// This use case deliberately **does not** create any fabricated `Coin` objects.
/// In a clean architecture, domain models must represent real data.  
/// If market data for a holding is missing we simply skip that asset – the
/// caller can decide how to handle incomplete portfolios (e.g., show an
/// empty state or partial list).  This approach keeps the domain layer free of
/// any assumptions about what constitutes “valid” data and avoids leaking
/// placeholder values into higher layers.
final class GetPortfolioAssetsUseCase {

    // MARK: - Dependencies

    private let portfolioRepository: PortfolioRepository
    private let coinRepository: CoinRepository

    // MARK: - Init

    init(
        portfolioRepository: PortfolioRepository,
        coinRepository: CoinRepository
    ) {
        self.portfolioRepository = portfolioRepository
        self.coinRepository = coinRepository
    }

    // MARK: - Public API

    /// Returns an array of `PortfolioAsset` objects that combine holdings with market data.
    ///
    /// Only assets for which market data is available are returned.  Assets
    /// without corresponding market information are omitted, but no error is thrown.
    func execute() async throws -> [PortfolioAsset] {
        // 1️⃣ Load all stored holdings.
        let holdings = try await portfolioRepository.holdings()

        guard !holdings.isEmpty else { return [] }

        // 2️⃣ Build a request to fetch market data for all holdings.
        // Use a perPage value that covers the number of holdings (max 250 is safe).
        let perPage = max(holdings.count, 250)
        let request = MarketRequest(
            currency: .usd,
            order: .marketCapDescending,
            page: 1,
            perPage: perPage,
            includeSparkline: false,
            priceChangePercentage: .day24
        )

        // 3️⃣ Fetch market data.
        let marketCoins = try await coinRepository.fetchMarkets(request: request)

        // 4️⃣ Create a dictionary for O(1) lookup by coin ID.
        var coinDict = [String: Coin]()
        for coin in marketCoins {
            coinDict[coin.id] = coin
        }

        // 5️⃣ Combine holdings with the corresponding market data.
        var assets: [PortfolioAsset] = []
        for holding in holdings {
            if let coin = coinDict[holding.coinID] {
                let asset = PortfolioAsset(holding: holding, coin: coin)
                assets.append(asset)
            } else {
                // Market data missing – skip this holding.  No placeholder is created.
                continue
            }
        }

        return assets
    }
}

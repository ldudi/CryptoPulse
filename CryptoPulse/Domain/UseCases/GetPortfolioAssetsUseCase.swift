import Foundation

/// Fetches portfolio holdings and enriches them with live market data.
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
                // If market data is missing we create a placeholder with zero price.
                let placeholderCoin = Coin(
                    id: holding.coinID,
                    symbol: holding.symbol,
                    name: holding.name,
                    imageURL: holding.imageURL,
                    currentPrice: 0.0,
                    marketCap: nil,
                    marketCapRank: nil,
                    priceChange24H: nil
                )
                let asset = PortfolioAsset(holding: holding, coin: placeholderCoin)
                assets.append(asset)
            }
        }

        return assets
    }
}

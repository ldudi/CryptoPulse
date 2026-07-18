import Foundation

// Mock implementation for preview purposes
final class MockCoinRepository: CoinRepository {
    func search(request: SearchRequest) async throws -> [Coin] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return [
            Coin(
                id: "bitcoin",
                symbol: "btc",
                name: "Bitcoin",
                imageURL: URL(string: "https://example.com/bitcoin.png"),
                currentPrice: 45000.0,
                marketCap: 870000000000.0,
                marketCapRank: 1,
                totalVolume: 25000000000.0,
                priceChange24H: 1200.0,
                priceChangePercentage24H: 2.7
            ),
            Coin(
                id: "ethereum",
                symbol: "eth",
                name: "Ethereum",
                imageURL: URL(string: "https://example.com/ethereum.png"),
                currentPrice: 3200.0,
                marketCap: 380000000000.0,
                marketCapRank: 2,
                totalVolume: 15000000000.0,
                priceChange24H: -50.0,
                priceChangePercentage24H: -1.5
            )
        ]
    }
}

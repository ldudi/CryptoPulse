import Foundation

final class ChartRepositoryImpl: ChartRepository {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchHistoricalPrices(
        coinId: String,
        range: ChartTimeRange
    ) async throws -> [ChartDataPoint] {
        let endpoint = CoinEndpoints.marketChart(
            id: coinId,
            days: range.rawValue
        )
        
        let dto = try await apiClient.request(endpoint)
        
        return dto.prices.map { point in
            ChartDataPoint(
                date: Date(timeIntervalSince1970: point.timestamp),
                price: point.price
            )
        }
    }
}

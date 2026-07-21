import Foundation

protocol ChartRepository: Sendable {
    func fetchHistoricalPrices(
        coinId: String,
        range: ChartTimeRange
    ) async throws -> [ChartDataPoint]
}

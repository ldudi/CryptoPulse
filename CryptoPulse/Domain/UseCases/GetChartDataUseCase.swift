import Foundation

final class GetChartDataUseCase {
    private let repository: ChartRepository

    init(repository: ChartRepository) {
        self.repository = repository
    }

    func execute(coinId: String, range: ChartTimeRange) async throws -> [ChartDataPoint] {
        return try await repository.fetchHistoricalPrices(
            coinId: coinId,
            range: range
        )
    }
}

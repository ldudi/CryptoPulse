import Foundation

final class UpdateHoldingUseCase {

    private let repository: PortfolioRepository

    init(repository: PortfolioRepository) {
        self.repository = repository
    }

    func execute(
        _ holding: PortfolioHolding
    ) async throws {

        try await repository.update(holding)
    }
}

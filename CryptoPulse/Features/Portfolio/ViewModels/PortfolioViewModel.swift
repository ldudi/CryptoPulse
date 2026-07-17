import Foundation
import Observation

@MainActor
@Observable
final class PortfolioViewModel {

    private let getPortfolio: GetPortfolioUseCase
    private let deleteHolding: DeleteHoldingUseCase

    private(set) var state = PortfolioState()

    init(
        getPortfolio: GetPortfolioUseCase,
        deleteHolding: DeleteHoldingUseCase
    ) {
        self.getPortfolio = getPortfolio
        self.deleteHolding = deleteHolding
    }

    func loadPortfolio() async {

        state.isLoading = true
        state.errorMessage = nil

        defer { state.isLoading = false }

        do {
            state.holdings = try await getPortfolio.execute()
        } catch {
            state.errorMessage = error.localizedDescription
        }
    }

    func deleteHolding(
        coinID: String
    ) async {

        do {
            try await deleteHolding.execute(coinID: coinID)
            await loadPortfolio()
        } catch {
            state.errorMessage = error.localizedDescription
        }
    }

    func refresh() async {
        await loadPortfolio()
    }
}

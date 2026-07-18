import Foundation
import Observation

@MainActor
@Observable
final class PortfolioViewModel {

    // MARK: - Dependencies

    private let getPortfolioAssetsUseCase: GetPortfolioAssetsUseCase
    private let deleteHoldingUseCase: DeleteHoldingUseCase

    // MARK: - State

    private(set) var state = PortfolioState()

    // MARK: - Init

    init(
        getPortfolioAssetsUseCase: GetPortfolioAssetsUseCase,
        deleteHoldingUseCase: DeleteHoldingUseCase
    ) {
        self.getPortfolioAssetsUseCase = getPortfolioAssetsUseCase
        self.deleteHoldingUseCase = deleteHoldingUseCase
    }

    // MARK: - Public API

    /// Loads the portfolio data and updates the UI state.
    func load() async {
        await refresh()
    }

    /// Refreshes the portfolio (used for pull‑to‑refresh).
    func refresh() async {
        state.status = .loading
        do {
            let assets = try await getPortfolioAssetsUseCase.execute()

            if assets.isEmpty {
                // No holdings – show empty state.
                state.assets = []
                state.totalValue = 0.0
                state.assetCount = 0
                state.totalCoins = 0.0
                state.largestHolding = nil
                state.status = .empty
            } else {
                // Populate assets and compute derived values.
                state.assets = assets
                computeDerivedValues()
                state.status = .loaded
            }
        } catch {
            state.status = .error(error)
        }
    }

    /// Deletes a holding and reloads the portfolio.
    func deleteHolding(coinID: String) async {
        do {
            try await deleteHoldingUseCase.execute(coinID: coinID)
            await refresh()
        } catch {
            state.status = .error(error)
        }
    }

    // MARK: - Private Helpers

    /// Computes total value, asset count, total coins and the largest holding.
    private func computeDerivedValues() {
        let totalValue = state.assets.reduce(0.0) { $0 + $1.currentValue }
        let assetCount = state.assets.count
        let totalCoins = state.assets.reduce(0.0) { $0 + $1.quantity }
        let largestHolding = state.assets.max(by: { ($0.currentValue ?? 0.0) < ($1.currentValue ?? 0.0) })

        state.totalValue = totalValue
        state.assetCount = assetCount
        state.totalCoins = totalCoins
        state.largestHolding = largestHolding
    }
}

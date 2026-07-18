import Foundation
import Observation

@MainActor
@Observable
final class PortfolioViewModel {

    // MARK: - Dependencies

    private let getPortfolioAssetsUseCase: GetPortfolioAssetsUseCase
    private let deleteHoldingUseCase: DeleteHoldingUseCase
    private let analyticsService: PortfolioAnalyticsService

    // MARK: - State

    private(set) var state = PortfolioState()

    // MARK: - Init

    init(
        getPortfolioAssetsUseCase: GetPortfolioAssetsUseCase,
        deleteHoldingUseCase: DeleteHoldingUseCase
    ) {
        self.getPortfolioAssetsUseCase = getPortfolioAssetsUseCase
        self.deleteHoldingUseCase = deleteHoldingUseCase
        self.analyticsService = PortfolioAnalyticsService()
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
                state.analytics = nil
                state.status = .empty
            } else {
                // Calculate analytics and update state
                let analytics = analyticsService.calculateAnalytics(from: assets)
                
                // Populate assets and compute derived values.
                state.assets = assets
                state.analytics = analytics
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
}

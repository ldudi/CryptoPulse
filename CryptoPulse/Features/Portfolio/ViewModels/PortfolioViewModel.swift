import Foundation
import Observation

@MainActor
@Observable
final class PortfolioViewModel {

    // MARK: - State

    private(set) var state: PortfolioViewState = .idle

    // MARK: - Dependencies

    private let getPortfolioAssetsUseCase: GetPortfolioAssetsUseCase
    private let deleteHoldingUseCase: DeleteHoldingUseCase

    // MARK: - Initializer

    init(
        getPortfolioAssetsUseCase: GetPortfolioAssetsUseCase,
        deleteHoldingUseCase: DeleteHoldingUseCase
    ) {
        self.getPortfolioAssetsUseCase = getPortfolioAssetsUseCase
        self.deleteHoldingUseCase = deleteHoldingUseCase
    }

    // MARK: - Computed Properties

    var assets: [PortfolioAsset] {
        guard case let .loaded(assets) = state else {
            return []
        }
        return assets
    }

    var isLoading: Bool {
        if case .loading = state {
            return true
        }
        return false
    }

    var isEmpty: Bool {
        if case .empty = state {
            return true
        }
        return false
    }

    var error: Error? {
        guard case let .failed(error) = state else {
            return nil
        }
        return error
    }

    // MARK: - Public Methods

    /// Loads the portfolio only once.
    func loadPortfolio() async {
        guard case .idle = state else { return }
        await fetchPortfolio()
    }

    /// Forces a refresh.
    func refresh() async {
        await fetchPortfolio()
    }

    /// Deletes a holding and refreshes the portfolio.
    func deleteHolding(coinID: String) async {
        do {
            try await deleteHoldingUseCase.execute(coinID: coinID)
            await fetchPortfolio()
        } catch {
            state = .failed(error)
        }
    }

    // MARK: - Private Methods

    private func fetchPortfolio() async {
        state = .loading

        do {
            let assets = try await getPortfolioAssetsUseCase.execute()

            if assets.isEmpty {
                state = .empty
            } else {
                state = .loaded(assets)
            }
        } catch {
            state = .failed(error)
        }
    }
}

import Foundation
import Observation

@MainActor
@Observable
final class PortfolioViewModel {
    
    // MARK: - State
    
    private(set) var state: PortfolioViewState = .idle
    
    // MARK: - Dependencies
    
    private let getPortfolioUseCase: GetPortfolioUseCase
    private let deleteHoldingUseCase: DeleteHoldingUseCase
    
    // MARK: - Init
    
    init(
        getPortfolioUseCase: GetPortfolioUseCase,
        deleteHoldingUseCase: DeleteHoldingUseCase
    ) {
        self.getPortfolioUseCase = getPortfolioUseCase
        self.deleteHoldingUseCase = deleteHoldingUseCase
    }
    
    // MARK: - Computed Properties
    
    var holdings: [PortfolioHolding] {
        guard case let .loaded(holdings) = state else { return [] }
        return holdings
    }
    
    var isLoading: Bool {
        if case .loading = state { return true }
        return false
    }
    
    var isEmpty: Bool {
        if case .empty = state { return true }
        return false
    }
    
    var error: Error? {
        guard case let .failed(error) = state else { return nil }
        return error
    }
    
    // MARK: - Actions
    
    /// Load the portfolio data if not already loaded.
    func loadPortfolio() async {
        guard case .idle = state else { return }
        await fetchPortfolio()
    }
    
    /// Refresh the portfolio data regardless of current state.
    func refresh() async {
        await fetchPortfolio()
    }
    
    /// Delete a holding by coin ID.
    func deleteHolding(coinID: String) async {
        do {
            try await deleteHoldingUseCase.execute(coinID: coinID)
            // After successful deletion, reload the portfolio
            await fetchPortfolio()
        } catch {
            // Error handling is done through state changes in fetchPortfolio
        }
    }
    
    // MARK: - Private
    
    /// Fetch portfolio data from the use case.
    private func fetchPortfolio() async {
        state = .loading
        
        do {
            let holdings = try await getPortfolioUseCase.execute()
            
            if holdings.isEmpty {
                state = .empty
            } else {
                state = .loaded(holdings)
            }
        } catch {
            state = .failed(error)
        }
    }
}

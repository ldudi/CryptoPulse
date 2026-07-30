import Foundation
import Observation

@MainActor
@Observable
final class MarketViewModel {

    // MARK: - State

    private(set) var state: MarketViewState = .idle

    // MARK: - Dependencies

    private let getMarketCoins: GetMarketCoinsUseCase

    // MARK: - Cache

    private var coins: [Coin] = []

    private var filteredCoinsStorage: [Coin] = []

    // MARK: - Initializer

    init(
        getMarketCoins: GetMarketCoinsUseCase
    ) {
        self.getMarketCoins = getMarketCoins
    }

    // MARK: - Public

    func loadMarkets() async {

        guard !isLoading else { return }

        state = .loading

        do {

            let markets = try await getMarketCoins(
                MarketRequest()
            )

            coins = markets
            filteredCoinsStorage = markets

            state = markets.isEmpty
                ? .empty
                : .loaded(markets)

        } catch {

            state = .failed(error)
        }
    }

    func refresh() async {

        await loadMarkets()
    }

    // MARK: - Search

    func filter(
        with query: String
    ) {

        guard !query.isEmpty else {

            filteredCoinsStorage = coins
            return
        }

        let lowercased = query.lowercased()

        filteredCoinsStorage = coins.filter {

            $0.name.lowercased().contains(lowercased)
            ||
            $0.symbol.lowercased().contains(lowercased)
        }
    }

    // MARK: - Helpers

    var displayedCoins: [Coin] {

        filteredCoinsStorage
    }

    var coinsCount: Int {

        filteredCoinsStorage.count
    }

    var isLoading: Bool {

        if case .loading = state {
            return true
        }

        return false
    }

    var error: Error? {

        if case .failed(let error) = state {
            return error
        }

        return nil
    }

    var hasContent: Bool {

        !filteredCoinsStorage.isEmpty
    }
}

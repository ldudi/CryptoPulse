//
//  MarketViewModel.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//  MarketViewState.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi.
//

import Foundation
import Observation

@MainActor
@Observable
final class MarketViewModel {

    // MARK: - State

    private(set) var state: MarketViewState = .idle

    var searchText = ""

    // MARK: - Dependencies

    private let getMarketCoins: GetMarketCoinsUseCase

    // MARK: - Cache

    private var coins: [Coin] = []

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

    var filteredCoins: [Coin] {

        guard !searchText.isEmpty else {

            return coins
        }

        let query = searchText.lowercased()

        return coins.filter {

            $0.name.lowercased().contains(query)
            ||
            $0.symbol.lowercased().contains(query)
        }
    }

    // MARK: - Helpers

    var displayedCoins: [Coin] {

        filteredCoins
    }

    var coinsCount: Int {

        displayedCoins.count
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

        !displayedCoins.isEmpty
    }
}

//
//  CoinDetailViewModel.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation

import Foundation
import Observation

@MainActor
@Observable
final class CoinDetailViewModel {

    // MARK: - State

    private(set) var state: CoinDetailViewState = .idle

    // MARK: - Dependencies

    private let coinID: String

    private let getCoinDetail: GetCoinDetailUseCase

    // MARK: - Init

    init(
        coinID: String,
        getCoinDetail: GetCoinDetailUseCase
    ) {
        self.coinID = coinID
        self.getCoinDetail = getCoinDetail
    }

    // MARK: - Derived Properties

    var coin: CoinDetail? {

        guard case let .loaded(coin) = state else {
            return nil
        }

        return coin
    }

    var isLoading: Bool {

        if case .loading = state {
            return true
        }

        return false
    }

    // MARK: - Actions

    func loadCoin() async {

        guard case .idle = state else {
            return
        }

        await fetchCoin()
    }

    func refresh() async {

        await fetchCoin()
    }

    // MARK: - Private

    private func fetchCoin() async {

        state = .loading

        do {

            let coin = try await getCoinDetail(
                id: coinID
            )

            state = .loaded(
                coin
            )

        } catch {

            state = .failed(
                error
            )
        }
    }
}

//
//  GetMarketCoinsUseCase.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  GetMarketCoinsUseCase.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi.
//

import Foundation

final class GetMarketCoinsUseCase {

    // MARK: - Properties

    private let repository: CoinRepository

    // MARK: - Initializer

    init(
        repository: CoinRepository
    ) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func callAsFunction(
        _ request: MarketRequest
    ) async throws -> [Coin] {

        try await repository.fetchMarkets(
            request: request
        )
    }
}

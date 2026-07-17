//
//  CoinRemoteDataSourceImpl.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//

import Foundation

final class CoinRemoteDataSourceImpl: CoinRemoteDataSource {

    private let apiClient: APIClient

    init(apiClient: APIClient) {

        self.apiClient = apiClient
    }

    func fetchMarkets(
        request: MarketRequest
    ) async throws -> [CoinDTO] {

        try await apiClient.request(

            CoinEndpoints.markets(
                request: request
            )
        )
    }
}

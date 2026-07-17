//
//  CoinRepositoryImpl.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  CoinRepositoryImpl.swift
//

import Foundation

final class CoinRepositoryImpl: CoinRepository {

    private let remoteDataSource: CoinRemoteDataSource

    init(
        remoteDataSource: CoinRemoteDataSource
    ) {

        self.remoteDataSource = remoteDataSource
    }

    func fetchMarkets(
        request: MarketRequest
    ) async throws -> [Coin] {

        let dtos = try await remoteDataSource.fetchMarkets(
            request: request
        )

        return CoinMapper.map(
            dtos: dtos
        )
    }
}

//
//  CoinRemoteDataSource.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  CoinRemoteDataSource.swift
//

import Foundation

import Foundation

protocol CoinRemoteDataSource {

    func fetchMarkets(
        request: MarketRequest
    ) async throws -> [CoinDTO]

    func fetchCoinDetail(
        id: String
    ) async throws -> CoinDetailDTO
}

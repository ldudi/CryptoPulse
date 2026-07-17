//
//  CoinRepository.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  CoinRepository.swift
//

import Foundation

protocol CoinRepository {

    func fetchMarkets(
        request: MarketRequest
    ) async throws -> [Coin]
}

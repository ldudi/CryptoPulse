//
//  GetMarketCoinsUseCaseProtocol.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  GetMarketCoinsUseCaseProtocol.swift
//

import Foundation

protocol GetMarketCoinsUseCaseProtocol {

    func execute(
        request: MarketRequest
    ) async throws -> [Coin]
}

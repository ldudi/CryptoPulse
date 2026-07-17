//
//  PortfolioRepository.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//  PortfolioRepository.swift
//  CryptoPulse
//

import Foundation

protocol PortfolioRepository: Sendable {

    func holdings() async throws -> [PortfolioHolding]

    func holding(
        for coinID: String
    ) async throws -> PortfolioHolding?

    func insert(
        _ holding: PortfolioHolding
    ) async throws

    func update(
        _ holding: PortfolioHolding
    ) async throws

    func delete(
        coinID: String
    ) async throws
}

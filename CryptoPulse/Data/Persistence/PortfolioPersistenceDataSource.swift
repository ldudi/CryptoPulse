//
//  PortfolioPersistenceDataSource.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//

import Foundation

protocol PortfolioPersistenceDataSource {

    func holdings() throws -> [PortfolioHoldingEntity]

    func holding(
        coinID: String
    ) throws -> PortfolioHoldingEntity?

    func insert(
        _ entity: PortfolioHoldingEntity
    ) throws

    func update(
        _ entity: PortfolioHoldingEntity
    ) throws

    func delete(
        _ entity: PortfolioHoldingEntity
    ) throws
}

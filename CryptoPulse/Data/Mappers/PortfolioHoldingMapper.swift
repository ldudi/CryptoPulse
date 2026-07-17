//
//  PortfolioHoldingMapper.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  PortfolioHoldingMapper.swift
//  CryptoPulse
//

import Foundation

enum PortfolioHoldingMapper {

    static func toDomain(
        _ entity: PortfolioHoldingEntity
    ) -> PortfolioHolding {

        PortfolioHolding(
            coinID: entity.coinID,
            symbol: entity.symbol,
            name: entity.name,
            imageURL: entity.imageURL.flatMap(URL.init(string:)),
            quantity: entity.quantity
        )
    }

    static func toEntity(
        _ holding: PortfolioHolding
    ) -> PortfolioHoldingEntity {

        PortfolioHoldingEntity(
            coinID: holding.coinID,
            symbol: holding.symbol,
            name: holding.name,
            imageURL: holding.imageURL?.absoluteString,
            quantity: holding.quantity
        )
    }
}

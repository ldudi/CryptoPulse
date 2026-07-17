//
//  CoinMapper.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  CoinMapper.swift
//

import Foundation

enum CoinMapper {

    static func map(
        dto: CoinDTO
    ) -> Coin {

        Coin(

            id: dto.id,

            symbol: dto.symbol.uppercased(),

            name: dto.name,

            imageURL: dto.image,

            currentPrice: dto.currentPrice,

            marketCap: dto.marketCap,

            marketCapRank: dto.marketCapRank,

            totalVolume: dto.totalVolume,

            high24H: dto.high24H,

            low24H: dto.low24H,

            priceChange24H: dto.priceChange24H,

            priceChangePercentage24H: dto.priceChangePercentage24H
        )
    }

    static func map(
        dtos: [CoinDTO]
    ) -> [Coin] {

        dtos.map(map)
    }
}

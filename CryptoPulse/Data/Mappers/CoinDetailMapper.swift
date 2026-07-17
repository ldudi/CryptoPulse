//
//  CoinDetailMapper.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation


import Foundation

enum CoinDetailMapper {

    static func map(
        _ dto: CoinDetailDTO
    ) -> CoinDetail {

        CoinDetail(

            id: dto.id,
            symbol: dto.symbol,
            name: dto.name,

            description: dto.description.english ?? "",

            imageURL: URL(
                string: dto.image.large
            ),

            currentPrice: dto.marketData.currentPrice["usd"] ?? 0,

            marketCap: dto.marketData.marketCap["usd"] ?? 0,

            volume: dto.marketData.totalVolume["usd"] ?? 0,

            high24h: dto.marketData.high24h["usd"] ?? 0,

            low24h: dto.marketData.low24h["usd"] ?? 0,

            priceChange24h: dto.marketData.priceChangePercentage24h ?? 0
        )
    }
}

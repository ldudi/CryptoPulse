//
//  CoinDTO.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  CoinDTO.swift
//  CryptoPulse
//

import Foundation

struct CoinDTO: Decodable, Identifiable {

    let id: String

    let symbol: String

    let name: String

    let image: URL?

    let currentPrice: Double

    let marketCap: Double

    let marketCapRank: Int?

    let totalVolume: Double

    let high24H: Double?

    let low24H: Double?

    let priceChange24H: Double?

    let priceChangePercentage24H: Double?

    enum CodingKeys: String, CodingKey {

        case id
        case symbol
        case name
        case image

        case currentPrice = "current_price"

        case marketCap = "market_cap"

        case marketCapRank = "market_cap_rank"

        case totalVolume = "total_volume"

        case high24H = "high_24h"

        case low24H = "low_24h"

        case priceChange24H = "price_change_24h"

        case priceChangePercentage24H = "price_change_percentage_24h"
    }
}

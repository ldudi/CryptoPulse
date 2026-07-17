//
//  MarketRequest.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  MarketRequest.swift
//  CryptoPulse
//

import Foundation

struct MarketRequest {

    var currency: Currency = .usd

    var order: MarketOrder = .marketCapDescending

    var page: Int = 1

    var perPage: Int = 100

    var includeSparkline = false

    var priceChangePercentage: PriceChangePeriod = .day24
}

// MARK: - Currency

enum Currency: String {

    case usd
    case eur
    case gbp
    case inr
}

// MARK: - Order

enum MarketOrder: String {

    case marketCapDescending = "market_cap_desc"

    case marketCapAscending = "market_cap_asc"

    case volumeDescending = "volume_desc"

    case volumeAscending = "volume_asc"

    case idAscending = "id_asc"

    case idDescending = "id_desc"
}

// MARK: - Price Change Period

enum PriceChangePeriod: String {

    case hour1 = "1h"

    case day24 = "24h"

    case day7 = "7d"

    case day14 = "14d"

    case day30 = "30d"

    case day200 = "200d"

    case year1 = "1y"
}

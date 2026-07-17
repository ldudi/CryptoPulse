//
//  CoinDetailDTO.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation

import Foundation

struct CoinDetailDTO: Decodable {

    let id: String
    let symbol: String
    let name: String
    let description: DescriptionDTO
    let image: ImageDTO
    let marketData: MarketDataDTO

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case description
        case image
        case marketData = "market_data"
    }
}

// MARK: - Nested DTOs

struct DescriptionDTO: Decodable {

    let english: String?

    enum CodingKeys: String, CodingKey {
        case english = "en"
    }
}

struct ImageDTO: Decodable {

    let thumb: String
    let small: String
    let large: String
}

struct MarketDataDTO: Decodable {

    let currentPrice: [String: Double]
    let marketCap: [String: Double]
    let totalVolume: [String: Double]
    let high24h: [String: Double]
    let low24h: [String: Double]
    let priceChangePercentage24h: Double?

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}

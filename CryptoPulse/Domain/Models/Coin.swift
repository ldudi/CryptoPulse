//
//  Coin.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  Coin.swift
//

import Foundation

struct Coin: Identifiable, Equatable {

    let id: String

    let symbol: String

    let name: String

    let imageURL: URL?

    let currentPrice: Double

    let marketCap: Double

    let marketCapRank: Int?

    let totalVolume: Double

    let high24H: Double?

    let low24H: Double?

    let priceChange24H: Double?

    let priceChangePercentage24H: Double?
}

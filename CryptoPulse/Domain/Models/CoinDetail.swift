//
//  CoinDetail.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
import Foundation

struct CoinDetail: Identifiable {

    let id: String
    let symbol: String
    let name: String

    let description: String

    let imageURL: URL?

    let currentPrice: Double
    let marketCap: Double
    let volume: Double

    let high24h: Double
    let low24h: Double

    let priceChange24h: Double
}

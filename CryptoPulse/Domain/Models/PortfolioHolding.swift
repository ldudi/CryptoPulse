//
//  PortfolioHolding.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//  PortfolioHolding.swift
//  CryptoPulse
//

import Foundation

struct PortfolioHolding: Identifiable, Equatable, Sendable {

    var id: String {
        coinID
    }

    let coinID: String
    let symbol: String
    let name: String
    let imageURL: URL?

    var quantity: Double

    init(
        coinID: String,
        symbol: String,
        name: String,
        imageURL: URL?,
        quantity: Double
    ) {
        self.coinID = coinID
        self.symbol = symbol
        self.name = name
        self.imageURL = imageURL
        self.quantity = quantity
    }
}

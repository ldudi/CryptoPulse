//
//  PortfolioHoldingEntity.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  PortfolioHoldingEntity.swift
//  CryptoPulse
//

import Foundation
import SwiftData

@Model
final class PortfolioHoldingEntity {

    @Attribute(.unique)
    var coinID: String

    var symbol: String

    var name: String

    var imageURL: String?

    var quantity: Double

    init(
        coinID: String,
        symbol: String,
        name: String,
        imageURL: String?,
        quantity: Double
    ) {
        self.coinID = coinID
        self.symbol = symbol
        self.name = name
        self.imageURL = imageURL
        self.quantity = quantity
    }
}

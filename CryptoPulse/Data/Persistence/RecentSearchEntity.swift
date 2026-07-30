//
//  RecentSearchEntity.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 30/07/26.
//

import Foundation
import SwiftData

@Model
final class RecentSearchEntity {

    @Attribute(.unique)
    var id: String

    var symbol: String

    var name: String

    var imageURL: String?

    var lastSearchedAt: Date

    init(
        id: String,
        symbol: String,
        name: String,
        imageURL: String?,
        lastSearchedAt: Date = .now
    ) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.imageURL = imageURL
        self.lastSearchedAt = lastSearchedAt
    }
}

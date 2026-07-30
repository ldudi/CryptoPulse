//
//  SearchSuggestion.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 30/07/26.
//

import Foundation

struct SearchSuggestion: Identifiable, Equatable {

    let id: String

    let symbol: String

    let name: String

    let imageURL: URL?
}

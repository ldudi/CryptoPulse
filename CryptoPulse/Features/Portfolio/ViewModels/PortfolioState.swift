//
//  PortfolioState.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  PortfolioState.swift
//  CryptoPulse
//

import Foundation

struct PortfolioState {

    var holdings: [PortfolioHolding] = []

    var isLoading = false

    var errorMessage: String?

    var totalValue: Double {
        holdings.reduce(0) { result, holding in
            result + holding.quantity
        }
    }

    var isEmpty: Bool {
        holdings.isEmpty
    }
}

//
//  MarketViewState.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//

import Foundation

enum MarketViewState {

    case idle

    case loading

    case loaded([Coin])

    case empty

    case failed(Error)
}

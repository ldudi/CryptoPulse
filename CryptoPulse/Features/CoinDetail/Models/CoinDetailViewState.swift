//
//  CoinDetailViewState.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation


import Foundation

enum CoinDetailViewState: Equatable {

    case idle

    case loading

    case loaded(CoinDetail)

    case failed(Error)

    static func == (
        lhs: CoinDetailViewState,
        rhs: CoinDetailViewState
    ) -> Bool {

        switch (lhs, rhs) {

        case (.idle, .idle):
            return true

        case (.loading, .loading):
            return true

        case (.loaded(let lhsCoin), .loaded(let rhsCoin)):
            return lhsCoin.id == rhsCoin.id

        case (.failed, .failed):
            return true

        default:
            return false
        }
    }
}

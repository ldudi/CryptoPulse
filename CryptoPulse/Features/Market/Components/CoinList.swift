//
//  CoinList.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  CoinList.swift
//  CryptoPulse
//

import SwiftUI

import SwiftUI

struct CoinList: View {

    let coins: [Coin]

    let onSelectCoin: (Coin) -> Void

    var body: some View {

        LazyVStack(
            spacing: Spacing.small
        ) {

            ForEach(coins) { coin in

                CoinRow(
                    coin: coin
                )
                .contentShape(
                    Rectangle()
                )
                .onTapGesture {

                    onSelectCoin(coin)
                }
            }
        }
    }
}

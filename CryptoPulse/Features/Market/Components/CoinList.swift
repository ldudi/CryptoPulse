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

struct CoinList: View {

    let coins: [Coin]

    var body: some View {

        LazyVStack(spacing: 12) {

            ForEach(coins) { coin in

                CoinRow(coin: coin)
            }
        }
    }
}

#Preview {

    ScrollView {

        CoinList(
            coins: []
        )
    }
}

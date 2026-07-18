//
//  CoinPriceCardView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//

import SwiftUI

struct CoinPriceCardView: View {

    let coin: CoinDetail

    var body: some View {

        VStack(alignment: .leading, spacing: Spacing.medium) {

            Text("Market")
                .font(.headline)

            DetailRow(
                title: "Current Price",
                value: coin.currentPrice.asCurrency()
            )

            DetailRow(
                title: "24h Change",
                value: coin.priceChange24h.asCurrency(),
                valueColor: coin.priceChange24h >= 0 ? .green : .red
            )

            DetailRow(
                title: "Market Cap",
                value: coin.marketCap.asAbbreviated()
            )

            DetailRow(
                title: "24h Volume",
                value: coin.volume.asAbbreviated()
            )

            DetailRow(
                title: "24h High",
                value: coin.high24h.asCurrency()
            )

            DetailRow(
                title: "24h Low",
                value: coin.low24h.asCurrency()
            )
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

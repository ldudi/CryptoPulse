//
//  CoinDetailLoadedView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
import SwiftUI

struct CoinDetailLoadedView: View {

    let coin: CoinDetail

    var body: some View {

        ScrollView {

            VStack(
                spacing: Spacing.large
            ) {

                RemoteImageView(
                    url: coin.imageURL
                )
                .frame(
                    width: 80,
                    height: 80
                )

                VStack(
                    spacing: Spacing.small
                ) {

                    Text(
                        coin.name
                    )
                    .font(
                        .title
                    )

                    Text(
                        coin.symbol.uppercased()
                    )
                    .foregroundStyle(
                        .secondary
                    )
                }

                CoinStatCard(
                    title: "Current Price",
                    value: coin.currentPrice.formatted(.currency(code: "USD"))
                )

                CoinStatCard(
                    title: "Market Cap",
                    value: coin.marketCap.formatted()
                )

                CoinStatCard(
                    title: "Volume",
                    value: coin.volume.formatted()
                )

                CoinStatCard(
                    title: "24h High",
                    value: coin.high24h.formatted(.currency(code: "USD"))
                )

                CoinStatCard(
                    title: "24h Low",
                    value: coin.low24h.formatted(.currency(code: "USD"))
                )

                CoinStatCard(
                    title: "24h Change",
                    value: "\(coin.priceChange24h.formatted())%"
                )

                if !coin.description.isEmpty {

                    VStack(
                        alignment: .leading,
                        spacing: Spacing.small
                    ) {

                        Text("Description")
                            .font(.headline)

                        Text(
                            coin.description
                        )
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                }
            }
            .padding()
        }
    }
}

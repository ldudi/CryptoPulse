//
//  CoinRow.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//
//  CoinRow.swift
//  CryptoPulse
//

import SwiftUI

struct CoinRow: View {

    let coin: Coin

    var body: some View {

        HStack(spacing: Spacing.medium) {

            // MARK: Rank

            Text("\(coin.marketCapRank)")
                .font(Typography.caption)
                .foregroundStyle(AppColors.secondaryText)
                .frame(width: 32)

            // MARK: Coin Image

            RemoteImageView(
                url: coin.imageURL
            )
            .frame(width: 44, height: 44)
            .clipShape(Circle())

            // MARK: Name

            VStack(alignment: .leading, spacing: 4) {

                Text(coin.name)
                    .font(Typography.headline)

                Text(coin.symbol)
                    .font(Typography.caption)
                    .foregroundStyle(AppColors.secondaryText)
            }

            Spacer()

            // MARK: Price

            VStack(alignment: .trailing, spacing: 6) {

                Text(
                    coin.currentPrice,
                    format: .currency(code: "USD")
                )
                .font(Typography.headline)

                PriceChangeBadge(
                    percentage: coin.priceChangePercentage24H ?? 0.0 // archi
                )
            }
        }
        .padding(.vertical, Spacing.small)
    }
}

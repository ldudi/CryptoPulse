//
//  CoinRow.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  CoinRow.swift
//  CryptoPulse
//

import SwiftUI

struct CoinRow: View {

    let rank: Int

    let symbol: String

    let name: String

    let price: String

    let change24H: Double

    var body: some View {

        HStack(spacing: Spacing.medium) {

            // MARK: Rank

            Text("\(rank)")
                .font(Typography.caption)
                .foregroundStyle(AppColors.secondaryText)
                .frame(width: 30)

            // MARK: Coin Icon

            Circle()
                .fill(AppColors.border)
                .frame(width: 44, height: 44)
                .overlay {

                    Text(symbol.prefix(1))
                        .font(Typography.headline)
                }

            // MARK: Coin Name

            VStack(alignment: .leading, spacing: 4) {

                Text(name)
                    .font(Typography.headline)

                Text(symbol.uppercased())
                    .font(Typography.caption)
                    .foregroundStyle(AppColors.secondaryText)
            }

            Spacer()

            // MARK: Price

            VStack(alignment: .trailing, spacing: 4) {

                Text(price)
                    .font(Typography.headline)

                HStack(spacing: 2) {

                    Image(
                        systemName: change24H >= 0
                        ? AppIcon.arrowUp
                        : AppIcon.arrowDown
                    )

                    Text(
                        String(format: "%.2f%%", abs(change24H))
                    )
                }
                .font(Typography.caption)
                .foregroundStyle(
                    change24H >= 0
                    ? AppColors.success
                    : AppColors.error
                )
            }
        }
        .padding(.vertical, Spacing.small)
    }
}

#Preview {

    VStack {

        CoinRow(
            rank: 1,
            symbol: "BTC",
            name: "Bitcoin",
            price: "$118,000",
            change24H: 2.6
        )

        CoinRow(
            rank: 2,
            symbol: "ETH",
            name: "Ethereum",
            price: "$3,400",
            change24H: -4.1
        )
    }
    .padding()
}

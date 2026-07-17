//
//  PortfolioRowView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  PortfolioRowView.swift
//  CryptoPulse
//

import SwiftUI

struct PortfolioRowView: View {

    let holding: PortfolioHolding

    var body: some View {

        HStack(spacing: 16) {

            AsyncImage(
                url: holding.imageURL
            ) { image in

                image
                    .resizable()
                    .scaledToFit()

            } placeholder: {

                ProgressView()
            }
            .frame(width: 40, height: 40)

            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                Text(holding.name)
                    .font(.headline)

                Text(
                    holding.symbol.uppercased()
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer()

            HoldingQuantityView(
                quantity: holding.quantity
            )
        }
        .padding(.vertical, 8)
    }
}

#Preview {

    PortfolioRowView(
        holding: PortfolioHolding(
            coinID: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            imageURL: URL(
                string: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png"
            ),
            quantity: 1.5
        )
    )
}

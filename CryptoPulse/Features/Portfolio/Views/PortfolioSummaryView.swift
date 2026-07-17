//
//  PortfolioSummaryView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  PortfolioSummaryView.swift
//  CryptoPulse
//

import SwiftUI

struct PortfolioSummaryView: View {

    let holdings: [PortfolioHolding]

    private var totalCoins: Double {

        holdings.reduce(0) {
            $0 + $1.quantity
        }
    }

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 16
        ) {

            Text("Portfolio")
                .font(.headline)

            HStack {

                VStack(
                    alignment: .leading
                ) {

                    Text("Assets")

                    Text(
                        "\(holdings.count)"
                    )
                    .font(.title2.bold())
                }

                Spacer()

                VStack(
                    alignment: .trailing
                ) {

                    Text("Total Coins")

                    Text(
                        totalCoins.formatted()
                    )
                    .font(.title2.bold())
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.thinMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 16
            )
        )
        .listRowInsets(
            EdgeInsets()
        )
        .listRowSeparator(.hidden)
    }
}

#Preview {

    PortfolioSummaryView(
        holdings: [
            PortfolioHolding(
                coinID: "bitcoin",
                symbol: "btc",
                name: "Bitcoin",
                imageURL: nil,
                quantity: 1.5
            ),
            PortfolioHolding(
                coinID: "ethereum",
                symbol: "eth",
                name: "Ethereum",
                imageURL: nil,
                quantity: 10
            )
        ]
    )
}

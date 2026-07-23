//
//  CurrentHoldingView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//

import SwiftUI

struct CurrentHoldingView: View {

    let holding: PortfolioHolding

    var body: some View {

        VStack(alignment: .leading, spacing: Spacing.medium) {

            Text("Your Holding")
                .font(.headline)

            DetailRow(
                title: "Quantity",
                value: holding.quantity.asNumber()
            )

            DetailRow(
                title: "Average Buy Price",
                value: holding.averageBuyPrice.asCurrency()
            )

            DetailRow(
                title: "Investment",
                value: (holding.quantity * holding.averageBuyPrice).asCurrency()
            )
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

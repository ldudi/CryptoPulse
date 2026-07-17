//
//  MarketHeaderView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  MarketHeaderView.swift
//  CryptoPulse
//

import SwiftUI

struct MarketHeaderView: View {

    let coinCount: Int

    var body: some View {

        HStack {

            VStack(alignment: .leading, spacing: 4) {

                Text("Markets")
                    .font(.largeTitle.bold())

                Text("\(coinCount) Cryptocurrencies")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {

    MarketHeaderView(
        coinCount: 100
    )
}

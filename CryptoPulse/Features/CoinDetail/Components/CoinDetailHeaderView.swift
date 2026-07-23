//
//  CoinDetailHeaderView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//

import SwiftUI

struct CoinDetailHeaderView: View {

    let coin: CoinDetail

    var body: some View {
        VStack(spacing: Spacing.medium) {

            AsyncImage(url: coin.imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)

            Text(coin.name)
                .font(.title.bold())

            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

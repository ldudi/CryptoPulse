import SwiftUI

struct CoinRowView: View {

    let coin: Coin

    var body: some View {

        HStack(spacing: Spacing.medium) {

            RemoteImageView(url: coin.imageURL)
                .frame(width: 48, height: 48)

            VStack(
                alignment: .leading,
                spacing: Spacing.xSmall
            ) {

                Text(coin.name)
                    .font(.headline)

                Text(coin.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(
                alignment: .trailing,
                spacing: Spacing.xSmall
            ) {

                Text(
                    coin.currentPrice,
                    format: .currency(code: "USD")
                )
                .font(.headline)

                if let change = coin.priceChangePercentage24H {

                    Text(
                        change / 100,
                        format: .percent
                    )
                    .font(.subheadline)
                    .foregroundStyle(
                        change >= 0
                        ? .green
                        : .red
                    )
                }
            }
        }
        .padding(.vertical, Spacing.small)
    }
}

#Preview {

    CoinRowView(
        coin: Coin(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            imageURL: nil,
            currentPrice: 118250.42,
            marketCap: 2_300_000_000_000,
            marketCapRank: 1,
            totalVolume: 58_000_000_000,
            high24H: 119000,
            low24H: 117100,
            priceChange24H: 1325.6,
            priceChangePercentage24H: 1.13
        )
    )
    .padding()
}

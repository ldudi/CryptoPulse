import SwiftUI

struct SearchCoinRow: View {
    let coin: Coin
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                AsyncImage(url: coin.imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(coin.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(coin.symbol.uppercased())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.vertical, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SearchCoinRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchCoinRow(coin: Coin(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            imageURL: URL(string: "https://example.com/bitcoin.png"),
            currentPrice: 45000.0,
            marketCap: 870000000000.0,
            marketCapRank: 1,
            totalVolume: 25000000000.0,
            priceChange24H: 1200.0,
            priceChangePercentage24H: 2.7
        )) {
            // Empty action for preview
        }
    }
}

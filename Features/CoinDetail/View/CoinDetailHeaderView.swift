import SwiftUI

struct CoinDetailHeaderView: View {
    let coin: CoinDetail
    
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: coin.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    Text(coin.symbol.uppercased())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(coin.currentPrice.asCurrency())
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 12)
    }
}

struct CoinDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailHeaderView(
            coin: CoinDetail(
                id: "bitcoin",
                symbol: "btc",
                name: "Bitcoin",
                description: "Bitcoin is a decentralized digital currency...",
                imageURL: URL(string: "https://example.com/bitcoin.png"),
                currentPrice: 45000.0,
                marketCap: 870000000000.0,
                totalVolume: 25000000000.0,
                circulatingSupply: 19300000.0,
                allTimeHigh: 68000.0,
                allTimeLow: 6700.0,
                priceChange24h: 1200.0
            )
        )
        .padding()
    }
}

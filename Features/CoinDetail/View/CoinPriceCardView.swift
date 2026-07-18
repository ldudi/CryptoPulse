import SwiftUI

struct CoinPriceCardView: View {
    let coin: CoinDetail
    
    var body: some View {
        CardView {
            VStack(spacing: 16) {
                HStack {
                    Text("Price")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(coin.currentPrice.asCurrency())
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                DividerView()
                
                HStack {
                    Text("24h Change")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(coin.priceChange24h.asPercentage())
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(coin.priceChangeColor)
                }
                
                DividerView()
                
                HStack {
                    Text("Market Cap")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(coin.marketCap.asCurrency())
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }
            .padding(.vertical, 16)
        }
    }
}

struct CoinPriceCardView_Previews: PreviewProvider {
    static var previews: some View {
        CoinPriceCardView(
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

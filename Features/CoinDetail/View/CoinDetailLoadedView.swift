import SwiftUI

struct CoinDetailLoadedView: View {
    let coin: CoinDetail
    @Bindable var viewModel: CoinDetailViewModel
    @State private var isShowingDeleteConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                CoinDetailHeaderView(coin: coin)
                
                CoinPriceCardView(coin: coin)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Description")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text(coin.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
                .padding(.top)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Market Data")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        DetailRow(title: "Market Cap", value: coin.marketCap.asCurrency())
                        DetailRow(title: "Total Volume", value: coin.totalVolume.asCurrency())
                        DetailRow(title: "Circulating Supply", value: coin.circulatingSupply.asNumber())
                        DetailRow(title: "All Time High", value: coin.allTimeHigh.asCurrency())
                        DetailRow(title: "All Time Low", value: coin.allTimeLow.asCurrency())
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
        }
        .alert("Delete Holding", isPresented: $isShowingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteHolding()
            }
        } message: {
            Text("Are you sure you want to delete this holding?")
        }
    }
}

struct CoinDetailLoadedView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailLoadedView(
            coin: CoinDetail(
                id: "bitcoin",
                symbol: "btc",
                name: "Bitcoin",
                description: "Bitcoin is a decentralized digital currency, without a central bank or single administrator, that can be sent from user to user on the peer-to-peer bitcoin network without intermediaries.",
                imageURL: URL(string: "https://example.com/bitcoin.png"),
                currentPrice: 45000.0,
                marketCap: 870000000000.0,
                totalVolume: 25000000000.0,
                circulatingSupply: 19300000.0,
                allTimeHigh: 68000.0,
                allTimeLow: 6700.0,
                priceChange24h: 1200.0
            ),
            viewModel: CoinDetailViewModel(coinID: "bitcoin")
        )
    }
}

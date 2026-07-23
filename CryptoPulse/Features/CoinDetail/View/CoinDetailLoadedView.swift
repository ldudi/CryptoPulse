import SwiftUI
import Observation

@MainActor
struct CoinDetailLoadedView: View {
    
    let coin: CoinDetail
    
    @Bindable var viewModel: CoinDetailViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // Coin Header
            if let coin = viewModel.coin {
                CoinDetailHeaderView(coin: coin)
            }
            
            CoinPriceCardView(
                coin: coin
            )
            
            // Chart Section - inserted between header and market stats
            ChartContainerView(viewModel: viewModel.chartViewModel)
                .frame(height: 200)
                .padding(.horizontal)
            
            // Market Statistics Section
            VStack(alignment: .leading, spacing: 12) {
                // Example market cap row
                HStack {
                    Text("Market Cap")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(viewModel.coin?.marketCap.asCurrency() ?? "")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                // Additional detail rows (e.g., volume, price change)
//                ForEach(viewModel.coin?.detailRows ?? [:]) { row in
//                    DetailRow(title: row.title, value: row.value, valueColor: row.valueColor)
//                }
            }
            .padding(.horizontal)
            
            // Add Holding Button
            Button(action: {
                viewModel.showEditor()
            }) {
                Text("Add Holding")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            // Time Range Picker
            HStack {
                Text("Time Range")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationTitle(viewModel.coin?.name ?? "")
    }
}

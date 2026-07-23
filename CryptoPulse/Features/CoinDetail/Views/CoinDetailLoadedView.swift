import SwiftUI
import Observation

@MainActor
struct CoinDetailLoadedView: View {
    @Bindable var viewModel: CoinDetailViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // Coin Header
            CoinDetailHeaderView(coin: viewModel.coin)
            
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
                    Text(viewModel.coin?.marketCap.formatCurrency() ?? "")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                // Additional detail rows (e.g., volume, price change)
                ForEach(viewModel.coin?.detailRows ?? []) { row in
                    DetailRow(title: row.title, value: row.value, valueColor: row.valueColor)
                }
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
                Button(action: {}) {
                    Text("30d")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.secondaryBackground)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(viewModel.coin?.name ?? "")
    }
}

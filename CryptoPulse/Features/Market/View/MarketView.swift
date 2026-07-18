import SwiftUI

struct MarketView: View {

    @State
    private var viewModel: MarketViewModel

    init(viewModel: MarketViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {

                case .idle:
                    Color.clear

                case .loading:
                    ProgressView()

                case .empty:
                    ContentUnavailableView(
                        "No Coins",
                        systemImage: "bitcoinsign.circle",
                        description: Text("No cryptocurrencies were found.")
                    )

                case .failed(let error):
                    ContentUnavailableView(
                        "Something went wrong",
                        systemImage: "exclamationmark.triangle",
                        description: Text(error.localizedDescription)
                    )

                case .loaded:
                    List(viewModel.displayedCoins) { coin in
                        CoinRowView(coin: coin)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Market")
            .searchable(text: $viewModel.searchText)
            .refreshable {
                await viewModel.refresh()
            }
            .task {
                if case .idle = viewModel.state {
                    await viewModel.loadMarkets()
                }
            }
        }
    }
}

import SwiftUI

struct CoinDetailContentView: View {
    @Bindable var viewModel: CoinDetailViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                ProgressView()
                
            case .loading:
                LoadingView()
                
            case .failed(let error):
                ErrorView(
                    title: "Unable to load coin",
                    message: error.localizedDescription
                ) {
                    Task {
                        await viewModel.refresh()
                    }
                }
                
            case .loaded(let coin):
                CoinDetailLoadedView(
                    coin: coin,
                    viewModel: viewModel
                )
                .background(
                    ChartContainerView(viewModel: viewModel.chartViewModel)
                        .transition(.opacity)
                )
            }
        }
        .navigationTitle("Coin Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

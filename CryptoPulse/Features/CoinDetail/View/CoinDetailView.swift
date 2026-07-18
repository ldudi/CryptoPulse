import SwiftUI

struct CoinDetailView: View {

    @State
    private var viewModel: CoinDetailViewModel

    init(viewModel: CoinDetailViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        CoinDetailContentView(
            viewModel: viewModel
        )
        .task {
            await viewModel.loadCoin()
        }
        .refreshable {
            await viewModel.refresh()
        }
    }
}

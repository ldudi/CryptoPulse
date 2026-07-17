import SwiftUI

struct PortfolioView: View {

    @State
    private var viewModel: PortfolioViewModel

    init(
        viewModel: PortfolioViewModel
    ) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Portfolio")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: { Task { await viewModel.refresh() } }) {
                            Image(systemName: AppIcon.refresh)
                        }
                    }
                }
                .task { await viewModel.load() }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state.status {

        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .empty:
            EmptyPortfolioView()

        case .error(let error):
            ErrorView(
                title: "Error",
                message: error.localizedDescription,
                buttonTitle: "Retry"
            ) {
                Task { await viewModel.refresh() }
            }

        case .loaded:
            VStack(spacing: Spacing.medium) {
                PortfolioSummaryView(state: viewModel.state)

                List(viewModel.state.assets) { asset in
                    PortfolioRowView(
                        asset: asset,
                        onDelete: {
                            Task { await viewModel.deleteHolding(coinID: asset.coinID) }
                        })
                }
                .listStyle(.plain)
            }
        }
    }
}

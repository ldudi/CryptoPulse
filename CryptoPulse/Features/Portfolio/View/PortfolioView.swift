import SwiftUI

struct PortfolioView: View {

    @State
    private var viewModel: PortfolioViewModel

    init(viewModel: PortfolioViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle("Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.refresh()
                        }
                    } label: {
                        Image(systemName: AppIcon.refresh)
                    }
                }
            }
            .task {
                await viewModel.loadPortfolio()
            }
            .refreshable {
                await viewModel.refresh()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {

        case .idle,
             .loading:

            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .empty:

            EmptyPortfolioView()

        case .failed(let error):

            ErrorView(
                title: "Unable to Load Portfolio",
                message: error.localizedDescription,
                buttonTitle: "Retry"
            ) {
                Task {
                    await viewModel.refresh()
                }
            }

        case .loaded:

            List(viewModel.assets) { asset in
                PortfolioRowView(
                    asset: asset,
                    onDelete: {
                        Task {
                            await viewModel.deleteHolding(
                                coinID: asset.coinID
                            )
                        }
                    }
                )
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    // Add preview once DI is available.
}

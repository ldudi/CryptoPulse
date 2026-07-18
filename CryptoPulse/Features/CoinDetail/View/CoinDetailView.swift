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
        .sheet(isPresented: $viewModel.isShowingEditor) {
            if let holding = viewModel.currentHolding {
                // Editing existing holding
                HoldingEditorView(
                    quantity: Binding<Double?>(get: { holding.quantity }, set: { _ in }),
                    averageBuyPrice: Binding<Double?>(get: { holding.averageBuyPrice }, set: { _ in }),
                    onSave: { quantity, buyPrice in
                        // For now we'll just save the quantity since we're not implementing buy price editing yet
                        Task {
                            await viewModel.saveHolding(quantity: quantity)
                        }
                    },
                    onCancel: {
                        viewModel.hideEditor()
                    }
                )
            } else {
                // Adding new holding
                HoldingEditorView(
                    quantity: Binding<Double?>(get: { nil }, set: { _ in }),
                    averageBuyPrice: Binding<Double?>(get: { nil }, set: { _ in }),
                    onSave: { quantity, buyPrice in
                        Task {
                            await viewModel.saveHolding(quantity: quantity)
                        }
                    },
                    onCancel: {
                        viewModel.hideEditor()
                    }
                )
            }
        }
    }
}

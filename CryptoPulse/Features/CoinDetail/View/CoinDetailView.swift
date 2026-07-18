import SwiftUI

struct CoinDetailView: View {

    @State
    private var viewModel: CoinDetailViewModel

    // Access the DI container to reach the coordinator.
    @Environment(DIContainer.self)
    private var container: DIContainer

    // Sheet & dialog state
    @State
    private var showEditor = false

    @State
    private var editorQuantity: Double? = nil

    @State
    private var showDeleteConfirmation = false

    init(
        viewModel: CoinDetailViewModel
    ) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.medium) {

                // Coin detail content
                CoinDetailContentView(viewModel: viewModel)
                    .onAppear {
                        Task { await viewModel.loadCoin() }
                    }

                // Loading / error states for the coin detail
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, Spacing.medium)
                } else if case let .failed(error) = viewModel.state {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(AppColors.warning)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, Spacing.large)
                }

                // Portfolio section
                VStack(alignment: .leading, spacing: Spacing.small) {
                    Text("Portfolio")
                        .font(.headline)

                    if let holding = viewModel.currentHolding {
                        HStack(spacing: Spacing.medium) {
                            Text("\(holding.quantity, specifier: "%.4f") \(viewModel.coin?.symbol ?? "")")
                                .font(.body)
                            Spacer()
                            Button(action: {
                                editorQuantity = holding.quantity
                                showEditor = true
                            }) {
                                Label("Edit", systemImage: AppIcon.edit)
                            }
                            .buttonStyle(.borderedProminent)

                            Button(role: .destructive, action: {
                                showDeleteConfirmation = true
                            }) {
                                Label("Delete", systemImage: AppIcon.trash)
                            }
                        }
                    } else {
                        Button(action: {
                            editorQuantity = 0.0
                            showEditor = true
                        }) {
                            Label("Add to Portfolio", systemImage: AppIcon.plus)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showEditor) {
            HoldingEditorView(
                quantity: $editorQuantity,
                onSave: { qty in
                    Task {
                        await viewModel.saveHolding(quantity: qty)
                        container.coordinator.showPortfolio()
                        showEditor = false
                    }
                },
                onCancel: {
                    showEditor = false
                })
        }
        .alert("Delete Holding", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                Task { await viewModel.deleteHolding(); container.coordinator.showPortfolio() }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this holding?")
        }
    }
}

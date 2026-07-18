import SwiftUI

struct CoinDetailLoadedView: View {

    let coin: CoinDetail

    @Bindable
    var viewModel: CoinDetailViewModel

    @State
    private var isShowingDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.large) {

                CoinDetailHeaderView(
                    coin: coin
                )

                CoinPriceCardView(
                    coin: coin
                )

                if let holding = viewModel.currentHolding {
                    CurrentHoldingView(
                        holding: holding
                    )
                }

                VStack(spacing: Spacing.medium) {

                    Button {
                        viewModel.showEditor()
                    } label: {
                        Label(
                            viewModel.currentHolding == nil
                                ? "Add Holding"
                                : "Edit Holding",
                            systemImage: viewModel.currentHolding == nil
                                ? "plus.circle.fill"
                                : "pencil.circle.fill"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isSaving)

                    if viewModel.currentHolding != nil {

                        Button(role: .destructive) {
                            isShowingDeleteConfirmation = true
                        } label: {
                            Label(
                                "Delete Holding",
                                systemImage: "trash"
                            )
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .disabled(viewModel.isSaving)
                    }
                }
            }
            .padding()
        }
        .confirmationDialog(
            "Delete Holding?",
            isPresented: $isShowingDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                Task {
                    await viewModel.deleteHolding()
                }
            }

            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This will permanently remove this holding from your portfolio.")
        }
    }
}

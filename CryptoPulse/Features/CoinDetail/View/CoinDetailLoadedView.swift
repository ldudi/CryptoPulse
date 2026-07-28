//
//  CoinDetailLoadedView.swift
//

import SwiftUI
import Observation

@MainActor
struct CoinDetailLoadedView: View {

    let coin: CoinDetail

    @Bindable
    var viewModel: CoinDetailViewModel

    var body: some View {

        ScrollView {

            LazyVStack(
                alignment: .leading,
                spacing: Spacing.large
            ) {

                CoinDetailHeaderView(
                    coin: coin
                )

                ChartContainerView(
                    viewModel: viewModel.chartViewModel
                )

                CoinPriceCardView(
                    coin: coin
                )

                if let holding = viewModel.currentHolding {

                    HoldingSummaryCard(
                        holding: holding,
                        currentPrice: coin.currentPrice
                    ) {
                        viewModel.showEditor()
                    }

                } else {

                    EmptyHoldingCard {
                        viewModel.showEditor()
                    }
                }

                if !coin.description.isEmpty {

                    CoinDescriptionCard(
                        description: coin.description
                    )
                }
            }
            .padding(.horizontal, Spacing.medium)
            .padding(.vertical, Spacing.medium)
        }
        .background(AppColors.background)
        .navigationTitle(coin.name)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {

            Button {

                viewModel.showEditor()

            } label: {

                Label(
                    viewModel.currentHolding == nil
                        ? "Add Holding"
                        : "Edit Holding",
                    systemImage: viewModel.currentHolding == nil
                        ? AppIcon.plus
                        : AppIcon.edit
                )
                .font(Typography.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.medium)
                .background(AppColors.accent)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: Radius.large,
                        style: .continuous
                    )
                )
            }
            .buttonStyle(.plain)
            .padding(.horizontal, Spacing.medium)
            .padding(.top, Spacing.small)
            .background(.ultraThinMaterial)
        }
    }
}

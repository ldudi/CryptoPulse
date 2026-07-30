//
//  MarketContentView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//

import SwiftUI

struct MarketContentView: View {

    @Bindable
    var viewModel: MarketViewModel

    @Bindable
    var searchViewModel: SearchViewModel

    let onSelectCoin: (Coin) -> Void
    let onSelectSuggestion: (SearchSuggestion) -> Void

    var body: some View {

        Group {

            switch viewModel.state {

            case .idle:

                ProgressView()

            case .loading:

                LoadingView()

            case .empty:

                EmptyStateView(
                    image: "",
                    title: "No Coins",
                    message: "No cryptocurrencies were found."
                )

            case .failed(let error):

                ErrorView(
                    title: "Something went wrong",
                    message: error.localizedDescription
                ) {

                    Task {

                        await viewModel.refresh()
                    }
                }

            case .loaded:

                ScrollView {

                    LazyVStack(
                        spacing: Spacing.medium
                    ) {

                        MarketHeaderView(
                            coinCount: viewModel.displayedCoins.count
                        )

                        SearchBar(
                            text: $searchViewModel.searchText,
                            placeholder: "Search coins"
                        )

                        if searchViewModel.shouldShowOverlay {

                            SearchOverlayView(
                                viewModel: searchViewModel,
                                onSelect: onSelectSuggestion
                            )
                            .transition(.opacity)
                            .zIndex(1)
                        }

                        CoinList(
                            coins: viewModel.displayedCoins,
                            onSelectCoin: onSelectCoin
                        )
                    }
                    .padding(.horizontal)
                }
                .refreshable {

                    await viewModel.refresh()
                }
            }
        }
    }
}

//
//  MarketContentView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  MarketContentView.swift
//  CryptoPulse
//

import SwiftUI

struct MarketContentView: View {

    @Bindable
    var viewModel: MarketViewModel

    let onSelectCoin: (Coin) -> Void

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
                            text: $viewModel.searchText,
                            placeholder: "Search coins"
                        )

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

//
//  MarketView.swift
//  CryptoPulse
//

import SwiftUI

struct MarketView: View {

    @Environment(DIContainer.self)
    private var container

    @State
    private var viewModel: MarketViewModel

    @State
    private var searchViewModel: SearchViewModel

    init(
        viewModel: MarketViewModel,
        searchViewModel: SearchViewModel
    ) {
        _viewModel = State(initialValue: viewModel)
        _searchViewModel = State(initialValue: searchViewModel)
    }

    var body: some View {

        MarketContentView(
            viewModel: viewModel,
            searchViewModel: searchViewModel,
            onSelectCoin: { coin in

                container.appCoordinator.navigate(
                    to: .coinDetail(coin.id)
                )
            },
            onSelectSuggestion: { suggestion in

                Task {

                    await searchViewModel.selectSuggestion(
                        suggestion
                    )

                    viewModel.filter(
                        with: suggestion.name
                    )
                }
            }
        )
        .navigationTitle("Market")
        .onChange(
            of: searchViewModel.searchText
        ) { _, newValue in

            viewModel.filter(
                with: newValue
            )
        }
        .task {

            await searchViewModel.loadRecentSearches()

            if case .idle = viewModel.state {

                await viewModel.loadMarkets()
            }
        }
    }
}

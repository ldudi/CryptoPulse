//
//  CoinDetailContentView.swift
//  CryptoPulse
//

import SwiftUI
import Observation

struct CoinDetailContentView: View {

    @Bindable var viewModel: CoinDetailViewModel

    var body: some View {

        Group {

            switch viewModel.state {

            case .idle, .loading:

                LoadingView()

            case .failed(let error):

                ErrorView(
                    title: "Unable to load coin",
                    message: error.localizedDescription
                ) {
                    Task {
                        await viewModel.refresh()
                    }
                }

            case .loaded(let coin):

                CoinDetailLoadedView(
                    coin: coin,
                    viewModel: viewModel
                )
            }
        }
        .navigationTitle(viewModel.coin?.name ?? "Coin")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.snappy, value: viewModel.state)
    }
}

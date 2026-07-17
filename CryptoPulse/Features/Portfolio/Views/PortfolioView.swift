//
//  PortfolioView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  PortfolioView.swift
//  CryptoPulse
//

import SwiftUI

struct PortfolioView: View {

    @State
    private var viewModel: PortfolioViewModel

    init(
        viewModel: PortfolioViewModel
    ) {
        _viewModel = State(
            initialValue: viewModel
        )
    }

    var body: some View {

        Group {

            if viewModel.state.isLoading {

                ProgressView()

            } else if let error = viewModel.state.errorMessage {

                ContentUnavailableView(
                    "Something went wrong",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error)
                )

            } else if viewModel.state.isEmpty {

                EmptyPortfolioView()

            } else {

                List {

                    PortfolioSummaryView(
                        holdings: viewModel.state.holdings
                    )

                    ForEach(
                        viewModel.state.holdings
                    ) { holding in

                        PortfolioRowView(
                            holding: holding
                        )
                    }
                    .onDelete(
                        perform: delete
                    )
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Portfolio")
        .task {

            await viewModel.loadPortfolio()
        }
        .refreshable {

            await viewModel.refresh()
        }
    }

    private func delete(
        at offsets: IndexSet
    ) {

        guard let index = offsets.first else {
            return
        }

        let holding = viewModel.state.holdings[index]

        Task {

            await viewModel.deleteHolding(
                coinID: holding.coinID
            )
        }
    }
}

//
//  CoinDetailView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//

import SwiftUI

struct CoinDetailView: View {

    @State
    private var viewModel: CoinDetailViewModel

    init(
        viewModel: CoinDetailViewModel
    ) {
        _viewModel = State(
            initialValue: viewModel
        )
    }

    var body: some View {

        CoinDetailContentView(
            viewModel: viewModel
        )
        .onAppear {

            Task {

                await viewModel.loadCoin()
            }
        }
    }
}

//
//  MarketView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//
//  MarketView.swift
//  CryptoPulse
//

import SwiftUI

struct MarketView: View {

    @State
    private var viewModel: MarketViewModel

    init(viewModel: MarketViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {

        MarketContentView(
            viewModel: viewModel
        )
        .onAppear {
            
            guard !viewModel.hasContent else { return }
            
            Task {
                await viewModel.loadMarkets()
            }
        }
    }
}

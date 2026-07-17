//
//  FeatureDependencies.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  FeatureDependencies.swift
//

import Foundation

struct FeatureDependencies {

    // MARK: - Core

    let appDependencies: AppDependencies

    // MARK: - Configuration

    var configuration: AppConfiguration {
        appDependencies.configuration
    }

    // MARK: - Logging

    var logger: AppLogger {
        appDependencies.logger
    }

    // MARK: - Market

    func makeMarketViewModel() -> MarketViewModel {

        MarketViewModel(
            getMarketCoins: appDependencies.getMarketCoinsUseCase
        )
    }

    // MARK: - Future Features

    // func makeCoinDetailViewModel(...)
    // func makePortfolioViewModel(...)
    // func makeFavoritesViewModel(...)
}

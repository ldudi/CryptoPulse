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
    
    func makeCoinDetailViewModel(
        coinID: String
    ) -> CoinDetailViewModel {

        CoinDetailViewModel(
            coinID: coinID,
            getCoinDetail: appDependencies.getCoinDetailUseCase,
            addHoldingUseCase: appDependencies.addHoldingUseCase,
            updateHoldingUseCase: appDependencies.updateHoldingUseCase,
            deleteHoldingUseCase: appDependencies.deleteHoldingUseCase,
            getHoldingUseCase: appDependencies.getHoldingUseCase
        )
    }
    
    func makePortfolioViewModel() -> PortfolioViewModel {

        PortfolioViewModel(
            getPortfolio: appDependencies.getPortfolioUseCase,
            deleteHolding: appDependencies.deleteHoldingUseCase
        )
    }

    // MARK: - Future Features
    // func makeFavoritesViewModel(...)
}

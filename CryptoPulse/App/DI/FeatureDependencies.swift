import Foundation

struct FeatureDependencies {

    let appDependencies: AppDependencies

    var configuration: AppConfiguration {
        appDependencies.configuration
    }

    var logger: AppLogger {
        appDependencies.logger
    }

    func makeMarketViewModel() -> MarketViewModel {
        MarketViewModel(
            getMarketCoins: appDependencies.getMarketCoinsUseCase
        )
    }

    func makeSearchViewModel() -> SearchViewModel {

        SearchViewModel(
            getSuggestions: appDependencies.getSearchSuggestionsUseCase,
            getRecentSearches: appDependencies.getRecentSearchesUseCase,
            saveRecentSearch: appDependencies.saveRecentSearchUseCase
        )
    }

    func makeCoinDetailViewModel(
        coinID: String
    ) -> CoinDetailViewModel {

        CoinDetailViewModel(
            coinID: coinID,
            getChartDataUseCase: appDependencies.getChartDataUseCase,
            getCoinDetail: appDependencies.getCoinDetailUseCase,
            addHoldingUseCase: appDependencies.addHoldingUseCase,
            updateHoldingUseCase: appDependencies.updateHoldingUseCase,
            deleteHoldingUseCase: appDependencies.deleteHoldingUseCase,
            getHoldingUseCase: appDependencies.getHoldingUseCase
        )
    }

    func makePortfolioViewModel() -> PortfolioViewModel {
        PortfolioViewModel(
            getPortfolioAssetsUseCase: appDependencies.getPortfolioAssetsUseCase,
            deleteHoldingUseCase: appDependencies.deleteHoldingUseCase
        )
    }
}

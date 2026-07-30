import Foundation
import SwiftData

@MainActor
final class AppDependencies {

    // MARK: - Core

    let configuration: AppConfiguration
    let logger: AppLogger
    let persistence: PersistenceController

    // MARK: - Networking

    let apiClient: APIClient

    // MARK: - Data Sources

    let coinRemoteDataSource: CoinRemoteDataSource

    // MARK: - Repositories

    let coinRepository: CoinRepository
    let portfolioRepository: PortfolioRepository
    let chartRepository: ChartRepository
    let searchRepository: SearchRepository

    // MARK: - Use Cases

    let getMarketCoinsUseCase: GetMarketCoinsUseCase
    let getCoinDetailUseCase: GetCoinDetailUseCase
    let addHoldingUseCase: AddHoldingUseCase
    let updateHoldingUseCase: UpdateHoldingUseCase
    let deleteHoldingUseCase: DeleteHoldingUseCase
    let getHoldingUseCase: GetHoldingUseCase
    let getPortfolioUseCase: GetPortfolioUseCase
    let getPortfolioAssetsUseCase: GetPortfolioAssetsUseCase
    let getChartDataUseCase: GetChartDataUseCase
    let getSearchSuggestionsUseCase: GetSearchSuggestionsUseCase
    let getRecentSearchesUseCase: GetRecentSearchesUseCase
    let saveRecentSearchUseCase: SaveRecentSearchUseCase

    // MARK: - Initializer

    init(
        configuration: AppConfiguration,
        persistence: PersistenceController
    ) {

        self.configuration = configuration
        self.persistence = persistence

        // MARK: Core

        let logger = LoggerFactory.makeLogger(category: .app)
        self.logger = logger

        // MARK: Networking

        let apiClient = Self.makeAPIClient()
        self.apiClient = apiClient

        // MARK: Data Sources

        let coinRemoteDataSource = Self.makeCoinRemoteDataSource(
            apiClient: apiClient
        )
        self.coinRemoteDataSource = coinRemoteDataSource

        // MARK: Repositories

        let coinRepository = Self.makeCoinRepository(
            remoteDataSource: coinRemoteDataSource
        )
        self.coinRepository = coinRepository

        let portfolioRepository = PortfolioRepositoryImpl(
            persistence: persistence
        )
        self.portfolioRepository = portfolioRepository

        let chartRepository = Self.makeChartRepository(
            apiClient: apiClient
        )
        self.chartRepository = chartRepository
        
        let searchRepository = Self.makeSearchRepository(
            modelContext: persistence.container.mainContext,
            apiClient: apiClient
        )
        self.searchRepository = searchRepository

        // MARK: Use Cases

        let getMarketCoinsUseCase = Self.makeGetMarketCoinsUseCase(
            repository: coinRepository
        )
        self.getMarketCoinsUseCase = getMarketCoinsUseCase

        let getCoinDetailUseCase = Self.makeGetCoinDetailUseCase(
            repository: coinRepository
        )
        self.getCoinDetailUseCase = getCoinDetailUseCase

        let addHoldingUseCase = AddHoldingUseCase(
            repository: portfolioRepository
        )
        self.addHoldingUseCase = addHoldingUseCase

        let updateHoldingUseCase = UpdateHoldingUseCase(
            repository: portfolioRepository
        )
        self.updateHoldingUseCase = updateHoldingUseCase

        let deleteHoldingUseCase = DeleteHoldingUseCase(
            repository: portfolioRepository
        )
        self.deleteHoldingUseCase = deleteHoldingUseCase

        let getPortfolioUseCase = GetPortfolioUseCase(
            repository: portfolioRepository
        )
        self.getPortfolioUseCase = getPortfolioUseCase

        let getHoldingUseCase = GetHoldingUseCase(
            repository: portfolioRepository
        )
        self.getHoldingUseCase = getHoldingUseCase

        // New use case for enriched assets
        let getPortfolioAssetsUseCase = GetPortfolioAssetsUseCase(
            portfolioRepository: portfolioRepository,
            coinRepository: coinRepository
        )
        self.getPortfolioAssetsUseCase = getPortfolioAssetsUseCase

        // New use case for chart data
        let getChartDataUseCase = Self.makeGetChartDataUseCase(
            repository: chartRepository
        )
        self.getChartDataUseCase = getChartDataUseCase
        
        let getSearchSuggestionsUseCase = GetSearchSuggestionsUseCase(
            repository: searchRepository
        )
        self.getSearchSuggestionsUseCase = getSearchSuggestionsUseCase

        let getRecentSearchesUseCase = GetRecentSearchesUseCase(
            repository: searchRepository
        )
        self.getRecentSearchesUseCase = getRecentSearchesUseCase

        let saveRecentSearchUseCase = SaveRecentSearchUseCase(
            repository: searchRepository
        )
        self.saveRecentSearchUseCase = saveRecentSearchUseCase
    }
}

// MARK: - Factory Methods

private extension AppDependencies {

    static func makeAPIClient() -> APIClient {
        URLSessionAPIClient()
    }

    static func makeCoinRemoteDataSource(
        apiClient: APIClient
    ) -> CoinRemoteDataSource {
        CoinRemoteDataSourceImpl(apiClient: apiClient)
    }

    static func makeCoinRepository(
        remoteDataSource: CoinRemoteDataSource
    ) -> CoinRepository {
        CoinRepositoryImpl(remoteDataSource: remoteDataSource)
    }

    static func makeChartRepository(
        apiClient: APIClient
    ) -> ChartRepository {
        ChartRepositoryImpl(apiClient: apiClient)
    }

    static func makeGetMarketCoinsUseCase(
        repository: CoinRepository
    ) -> GetMarketCoinsUseCase {
        GetMarketCoinsUseCase(repository: repository)
    }

    static func makeGetCoinDetailUseCase(
        repository: CoinRepository
    ) -> GetCoinDetailUseCase {
        GetCoinDetailUseCase(repository: repository)
    }

    static func makeGetChartDataUseCase(
        repository: ChartRepository
    ) -> GetChartDataUseCase {
        GetChartDataUseCase(repository: repository)
    }
    
    static func makeSearchRepository(
        modelContext: ModelContext,
        apiClient: APIClient
    ) -> SearchRepository {

        SearchRepositoryImpl(
            modelContext: modelContext,
            apiClient: apiClient
        )
    }
}

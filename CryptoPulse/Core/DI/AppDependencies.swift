import Foundation

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

    // MARK: - Use Cases

    let getMarketCoinsUseCase: GetMarketCoinsUseCase
    let getCoinDetailUseCase: GetCoinDetailUseCase

    // MARK: - Portfolio Use Cases

    let addHoldingUseCase: AddHoldingUseCase
    let updateHoldingUseCase: UpdateHoldingUseCase
    let deleteHoldingUseCase: DeleteHoldingUseCase
    let getPortfolioUseCase: GetPortfolioUseCase
    let getHoldingUseCase: GetHoldingUseCase

    // MARK: - Initializer

    init(
        configuration: AppConfiguration,
        persistence: PersistenceController
    ) {

        self.configuration = configuration
        self.persistence = persistence

        // MARK: Core

        let logger = LoggerFactory.makeLogger(category: .app)

        // MARK: Networking

        let apiClient = Self.makeAPIClient()

        // MARK: Data Sources

        let coinRemoteDataSource = Self.makeCoinRemoteDataSource(
            apiClient: apiClient
        )

        // MARK: Repositories

        let coinRepository = Self.makeCoinRepository(
            remoteDataSource: coinRemoteDataSource
        )

        let portfolioRepository = PortfolioRepositoryImpl(
            persistence: persistence
        )

        // MARK: Use Cases

        let getMarketCoinsUseCase = Self.makeGetMarketCoinsUseCase(
            repository: coinRepository
        )

        let getCoinDetailUseCase = Self.makeGetCoinDetailUseCase(
            repository: coinRepository
        )

        let addHoldingUseCase = AddHoldingUseCase(
            repository: portfolioRepository
        )

        let updateHoldingUseCase = UpdateHoldingUseCase(
            repository: portfolioRepository
        )

        let deleteHoldingUseCase = DeleteHoldingUseCase(
            repository: portfolioRepository
        )

        let getPortfolioUseCase = GetPortfolioUseCase(
            repository: portfolioRepository
        )

        let getHoldingUseCase = GetHoldingUseCase(
            repository: portfolioRepository
        )

        // MARK: Assign

        self.logger = logger
        self.apiClient = apiClient
        self.coinRemoteDataSource = coinRemoteDataSource

        self.coinRepository = coinRepository
        self.portfolioRepository = portfolioRepository

        self.getMarketCoinsUseCase = getMarketCoinsUseCase
        self.getCoinDetailUseCase = getCoinDetailUseCase

        self.addHoldingUseCase = addHoldingUseCase
        self.updateHoldingUseCase = updateHoldingUseCase
        self.deleteHoldingUseCase = deleteHoldingUseCase
        self.getPortfolioUseCase = getPortfolioUseCase
        self.getHoldingUseCase = getHoldingUseCase
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
}

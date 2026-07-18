import Foundation

@Observable
final class DIContainer {
    
    // MARK: - Dependencies
    
    private(set) var appDependencies: AppDependencies!
    private(set) var marketDependencies: MarketDependencies!
    private(set) var portfolioDependencies: PortfolioDependencies!
    private(set) var settingsDependencies: SettingsDependencies!
    
    // MARK: - Init
    
    init() {
        setupDependencies()
    }
    
    // MARK: - Private API
    
    private func setupDependencies() {
        appDependencies = AppDependencies()
        marketDependencies = MarketDependencies(appDependencies: appDependencies)
        portfolioDependencies = PortfolioDependencies(appDependencies: appDependencies)
        settingsDependencies = SettingsDependencies(appDependencies: appDependencies)
    }
}

// MARK: - MarketDependencies

struct MarketDependencies {
    let appDependencies: AppDependencies
    let coinRepository: CoinRepository
    
    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
        self.coinRepository = CoinRepositoryImpl(
            remoteDataSource: CoinRemoteDataSourceImpl(apiClient: APIClientImpl(logger: appDependencies.logger))
        )
    }
}

// MARK: - PortfolioDependencies

struct PortfolioDependencies {
    let appDependencies: AppDependencies
    let portfolioRepository: PortfolioRepository
    
    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
        self.portfolioRepository = CoinRepositoryImpl(
            remoteDataSource: CoinRemoteDataSourceImpl(apiClient: APIClientImpl(logger: appDependencies.logger))
        )
    }
}

// MARK: - SettingsDependencies

struct SettingsDependencies {
    let appDependencies: AppDependencies
    
    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }
}

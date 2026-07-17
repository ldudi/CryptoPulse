//
//  AppDependencies.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  AppDependencies.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi.
//

import Foundation

@MainActor
final class AppDependencies {

    // MARK: - Core

    let configuration: AppConfiguration
    let logger: AppLogger

    // MARK: - Networking

    let apiClient: APIClient

    // MARK: - Data Sources

    let coinRemoteDataSource: CoinRemoteDataSource

    // MARK: - Repositories

    let coinRepository: CoinRepository

    // MARK: - Use Cases

    let getMarketCoinsUseCase: GetMarketCoinsUseCase
    let getCoinDetailUseCase: GetCoinDetailUseCase

    // MARK: - Initializer

    init(configuration: AppConfiguration) {

        self.configuration = configuration

        // Core

        let logger = LoggerFactory.makeLogger(category: .app)

        // Networking

        let apiClient = Self.makeAPIClient()

        // Data Sources

        let coinRemoteDataSource = Self.makeCoinRemoteDataSource(
            apiClient: apiClient
        )

        // Repositories

        let coinRepository = Self.makeCoinRepository(
            remoteDataSource: coinRemoteDataSource
        )

        // Use Cases

        let getMarketCoinsUseCase = Self.makeGetMarketCoinsUseCase(
            repository: coinRepository
        )

        let getCoinDetailUseCase = Self.makeGetCoinDetailUseCase(
            repository: coinRepository
        )

        // Assign

        self.logger = logger
        self.apiClient = apiClient
        self.coinRemoteDataSource = coinRemoteDataSource
        self.coinRepository = coinRepository
        self.getMarketCoinsUseCase = getMarketCoinsUseCase
        self.getCoinDetailUseCase = getCoinDetailUseCase
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

        CoinRemoteDataSourceImpl(
            apiClient: apiClient
        )
    }

    static func makeCoinRepository(
        remoteDataSource: CoinRemoteDataSource
    ) -> CoinRepository {

        CoinRepositoryImpl(
            remoteDataSource: remoteDataSource
        )
    }

    static func makeGetMarketCoinsUseCase(
        repository: CoinRepository
    ) -> GetMarketCoinsUseCase {

        GetMarketCoinsUseCase(
            repository: repository
        )
    }
    
    static func makeGetCoinDetailUseCase(
        repository: CoinRepository
    ) -> GetCoinDetailUseCase {

        GetCoinDetailUseCase(
            repository: repository
        )
    }
}

//
//  GetCoinDetailUseCase.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation


import Foundation

struct GetCoinDetailUseCase {

    private let repository: CoinRepository

    init(
        repository: CoinRepository
    ) {
        self.repository = repository
    }

    func callAsFunction(
        id: String
    ) async throws -> CoinDetail {

        try await repository.getCoinDetail(
            id: id
        )
    }
}

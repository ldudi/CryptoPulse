//
//  GetHoldingUseCase.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  GetHoldingUseCase.swift
//  CryptoPulse
//

import Foundation

struct GetHoldingUseCase: Sendable {

    private let repository: PortfolioRepository

    init(
        repository: PortfolioRepository
    ) {
        self.repository = repository
    }

    func execute(
        coinID: String
    ) async throws -> PortfolioHolding? {

        try await repository.holding(
            for: coinID
        )
    }
}

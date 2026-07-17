//
//  DeleteHoldingUseCase.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  DeleteHoldingUseCase.swift
//  CryptoPulse
//

import Foundation

struct DeleteHoldingUseCase: Sendable {

    private let repository: PortfolioRepository

    init(
        repository: PortfolioRepository
    ) {
        self.repository = repository
    }

    func execute(
        coinID: String
    ) async throws {

        try await repository.delete(
            coinID: coinID
        )
    }
}

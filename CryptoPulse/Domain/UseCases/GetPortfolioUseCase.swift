//
//  GetPortfolioUseCase.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  GetPortfolioUseCase.swift
//  CryptoPulse
//

import Foundation

struct GetPortfolioUseCase: Sendable {

    private let repository: PortfolioRepository

    init(
        repository: PortfolioRepository
    ) {
        self.repository = repository
    }

    func execute() async throws -> [PortfolioHolding] {

        try await repository.holdings()
    }
}

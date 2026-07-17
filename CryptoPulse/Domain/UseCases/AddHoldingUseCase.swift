//
//  AddHoldingUseCase.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  AddHoldingUseCase.swift
//  CryptoPulse
//

import Foundation

struct AddHoldingUseCase: Sendable {

    private let repository: PortfolioRepository

    init(
        repository: PortfolioRepository
    ) {
        self.repository = repository
    }

    func execute(
        _ holding: PortfolioHolding
    ) async throws {

        try await repository.insert(holding)
    }
}

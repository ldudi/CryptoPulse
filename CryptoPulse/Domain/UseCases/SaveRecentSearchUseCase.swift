//
//  SaveRecentSearchUseCase.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 30/07/26.
//

import Foundation

struct SaveRecentSearchUseCase {

    // MARK: - Properties

    private let repository: SearchRepository

    // MARK: - Initializer

    init(
        repository: SearchRepository
    ) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func callAsFunction(
        _ suggestion: SearchSuggestion
    ) async throws {

        try await repository.saveRecentSearch(
            suggestion
        )
    }
}

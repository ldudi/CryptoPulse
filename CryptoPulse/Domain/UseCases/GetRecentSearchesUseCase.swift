//
//  GetRecentSearchesUseCase.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 30/07/26.
//

import Foundation

struct GetRecentSearchesUseCase {

    // MARK: - Properties

    private let repository: SearchRepository

    // MARK: - Initializer

    init(
        repository: SearchRepository
    ) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func callAsFunction() async throws -> [SearchSuggestion] {

        try await repository.getRecentSearches()
    }
}

//
//  GetSearchSuggestionsUseCase.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 30/07/26.
//

import Foundation

struct GetSearchSuggestionsUseCase {

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
        query: String
    ) async throws -> [SearchSuggestion] {

        try await repository.getSearchSuggestions(
            query: query
        )
    }
}

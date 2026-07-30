//
//  SearchRepository.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 30/07/26.
//

import Foundation

protocol SearchRepository {

    func getRecentSearches() async throws -> [SearchSuggestion]

    func saveRecentSearch(
        _ suggestion: SearchSuggestion
    ) async throws

    func getSearchSuggestions(
        query: String
    ) async throws -> [SearchSuggestion]
}

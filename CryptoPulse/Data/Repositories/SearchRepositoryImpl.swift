//
//  SearchRepositoryImpl.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 30/07/26.
//

import Foundation
import SwiftData

final class SearchRepositoryImpl: SearchRepository {

    // MARK: - Constants

    private enum Constants {

        static let maxRecentSearches = 10
    }

    // MARK: - Properties

    private let modelContext: ModelContext
    private let apiClient: APIClient

    // MARK: - Initializer

    init(
        modelContext: ModelContext,
        apiClient: APIClient
    ) {
        self.modelContext = modelContext
        self.apiClient = apiClient
    }

    // MARK: - Recent Searches

    func getRecentSearches() async throws -> [SearchSuggestion] {

        var descriptor = FetchDescriptor<RecentSearchEntity>(
            sortBy: [
                SortDescriptor(
                    \.lastSearchedAt,
                    order: .reverse
                )
            ]
        )

        descriptor.fetchLimit = Constants.maxRecentSearches

        let entities = try modelContext.fetch(descriptor)

        return entities.map {
            SearchSuggestion(
                id: $0.id,
                symbol: $0.symbol,
                name: $0.name,
                imageURL: $0.imageURL.flatMap(URL.init(string:))
            )
        }
    }

    func saveRecentSearch(
        _ suggestion: SearchSuggestion
    ) async throws {

        let suggestionID = suggestion.id

        let descriptor = FetchDescriptor<RecentSearchEntity>(
            predicate: #Predicate<RecentSearchEntity> { entity in
                entity.id == suggestionID
            }
        )

        if let existing = try modelContext.fetch(descriptor).first {

            existing.name = suggestion.name
            existing.symbol = suggestion.symbol
            existing.imageURL = suggestion.imageURL?.absoluteString
            existing.lastSearchedAt = .now

        } else {

            let entity = RecentSearchEntity(
                id: suggestion.id,
                symbol: suggestion.symbol,
                name: suggestion.name,
                imageURL: suggestion.imageURL?.absoluteString
            )

            modelContext.insert(entity)
        }

        try modelContext.save()

        try removeOldRecentSearches()
    }

    // MARK: - Suggestions

    func getSearchSuggestions(
        query: String
    ) async throws -> [SearchSuggestion] {

        let trimmedQuery = query.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedQuery.isEmpty else {
            return []
        }

        let response = try await apiClient.request(
            CoinEndpoints.search(query: trimmedQuery)
        )

        return response.coins.map {
            SearchSuggestion(
                id: $0.id,
                symbol: $0.symbol,
                name: $0.name,
                imageURL: URL(string: $0.thumb)
            )
        }
    }

    // MARK: - Private

    private func removeOldRecentSearches() throws {

        let descriptor = FetchDescriptor<RecentSearchEntity>(
            sortBy: [
                SortDescriptor(
                    \.lastSearchedAt,
                    order: .reverse
                )
            ]
        )

        let searches = try modelContext.fetch(descriptor)

        guard searches.count > Constants.maxRecentSearches else {
            return
        }

        searches
            .dropFirst(Constants.maxRecentSearches)
            .forEach { modelContext.delete($0) }

        try modelContext.save()
    }
}

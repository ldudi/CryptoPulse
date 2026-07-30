//
//  SearchViewModel.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 30/07/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class SearchViewModel {

    // MARK: - State

    var searchText = "" {
        didSet {
            debounceSearch()
        }
    }

    private(set) var suggestions: [SearchSuggestion] = []

    private(set) var recentSearches: [SearchSuggestion] = []

    private(set) var isSearching = false

    // MARK: - Dependencies

    private let getSuggestions: GetSearchSuggestionsUseCase

    private let getRecentSearches: GetRecentSearchesUseCase

    private let saveRecentSearch: SaveRecentSearchUseCase

    // MARK: - Private

    private var debounceTask: Task<Void, Never>?
    
    var shouldShowOverlay: Bool {

        !searchText.isEmpty
        ||
        !recentSearches.isEmpty
    }

    // MARK: - Initializer

    init(
        getSuggestions: GetSearchSuggestionsUseCase,
        getRecentSearches: GetRecentSearchesUseCase,
        saveRecentSearch: SaveRecentSearchUseCase
    ) {
        self.getSuggestions = getSuggestions
        self.getRecentSearches = getRecentSearches
        self.saveRecentSearch = saveRecentSearch
    }

    // MARK: - Public

    func loadRecentSearches() async {

        do {

            recentSearches = try await getRecentSearches()

        } catch {

            print(error)
        }
    }

    func selectSuggestion(
        _ suggestion: SearchSuggestion
    ) async {

        searchText = suggestion.name

        suggestions.removeAll()

        do {

            try await saveRecentSearch(
                suggestion
            )

            await loadRecentSearches()

        } catch {

            print(error)
        }
    }

    // MARK: - Debounce

    private func debounceSearch() {

        debounceTask?.cancel()

        guard !searchText.isEmpty else {

            suggestions.removeAll()

            return
        }

        debounceTask = Task {

            try? await Task.sleep(
                for: .milliseconds(300)
            )

            guard !Task.isCancelled else {

                return
            }

            await search()
        }
    }

    private func search() async {

        isSearching = true

        defer {

            isSearching = false
        }

        do {

            suggestions = try await getSuggestions(
                query: searchText
            )

        } catch {

            suggestions = []
        }
    }
}

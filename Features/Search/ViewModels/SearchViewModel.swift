import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var searchResults: [Coin] = []
    @Published var recentSearches: [String] = []
    @Published var isLoading = false
    @Published var hasError = false
    @Published var hasNoResults = false
    
    private let coinRepository: CoinRepository
    private var searchCancellable: AnyCancellable?
    private var debounceTimer: Timer?
    
    init(coinRepository: CoinRepository) {
        self.coinRepository = coinRepository
        loadRecentSearches()
    }
    
    func performSearch() {
        guard !query.isEmpty else {
            searchResults = []
            hasNoResults = false
            hasError = false
            return
        }
        
        isLoading = true
        hasError = false
        hasNoResults = false
        
        // Cancel previous search if exists
        searchCancellable?.cancel()
        
        searchCancellable = Task {
            do {
                let request = SearchRequest(query: query)
                let results = try await coinRepository.search(request: request)
                searchResults = results
                hasNoResults = results.isEmpty
                isLoading = false
                
                // Add to recent searches if not already present
                addToRecentSearches(query)
            } catch {
                hasError = true
                isLoading = false
                searchResults = []
                hasNoResults = false
            }
        }.publisher
    }
    
    func clearSearch() {
        query = ""
        searchResults = []
        hasNoResults = false
        hasError = false
    }
    
    func clearRecentSearches() {
        recentSearches.removeAll()
        saveRecentSearches()
    }
    
    func removeRecentSearch(_ search: String) {
        recentSearches.removeAll { $0 == search }
        saveRecentSearches()
    }
    
    func addToRecentSearches(_ search: String) {
        guard !search.isEmpty else { return }
        
        // Remove if already exists
        recentSearches.removeAll { $0 == search }
        
        // Add to beginning
        recentSearches.insert(search, at: 0)
        
        // Keep only last 10
        if recentSearches.count > 10 {
            recentSearches.removeLast(recentSearches.count - 10)
        }
        
        saveRecentSearches()
    }
    
    private func loadRecentSearches() {
        // Load from UserDefaults or other persistence
        if let savedSearches = UserDefaults.standard.array(forKey: "recent_searches") as? [String] {
            recentSearches = savedSearches
        }
    }
    
    private func saveRecentSearches() {
        // Save to UserDefaults
        UserDefaults.standard.set(recentSearches, forKey: "recent_searches")
    }
}

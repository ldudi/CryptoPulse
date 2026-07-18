import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    let onCoinSelected: (String) -> Void
    
    init(coinRepository: CoinRepository, onCoinSelected: @escaping (String) -> Void) {
        _viewModel = StateObject(wrappedValue: SearchViewModel(coinRepository: coinRepository))
        self.onCoinSelected = onCoinSelected
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search coins...", text: $viewModel.query)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            viewModel.performSearch()
                        }
                    
                    if !viewModel.query.isEmpty {
                        Button("Cancel") {
                            viewModel.clearSearch()
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Content based on state
                if viewModel.query.isEmpty {
                    recentSearchesView
                } else {
                    searchResultsView
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: viewModel.query) { newValue in
            debounceSearch()
        }
    }
    
    private var recentSearchesView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if !viewModel.recentSearches.isEmpty {
                    HStack {
                        Text("Recent Searches")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        Button("Clear") {
                            viewModel.clearRecentSearches()
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)
                    
                    ForEach(viewModel.recentSearches, id: \.self) { search in
                        HStack {
                            Button(action: {
                                viewModel.query = search
                                viewModel.performSearch()
                            }) {
                                Text(search)
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal)
                            }
                            
                            Button(action: {
                                viewModel.removeRecentSearch(search)
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                                    .imageScale(.small)
                                    .padding(.trailing, 12)
                            }
                        }
                        .background(Color.secondarySystemBackground)
                        .padding(.horizontal)
                    }
                } else {
                    EmptySearchStateView()
                }
            }
        }
    }
    
    private var searchResultsView: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Searching...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.hasError {
                ErrorSearchStateView()
            } else if viewModel.hasNoResults {
                EmptySearchStateView()
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.searchResults) { coin in
                        SearchCoinRow(coin: coin) {
                            viewModel.addToRecentSearches(coin.name)
                            onCoinSelected(coin.id)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    private func debounceSearch() {
        viewModel.debounceTimer?.invalidate()
        viewModel.debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            viewModel.performSearch()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(coinRepository: MockCoinRepository()) { _ in }
    }
}

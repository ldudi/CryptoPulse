//
//  SearchOverlayView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 30/07/26.
//

import SwiftUI

struct SearchOverlayView: View {

    let viewModel: SearchViewModel

    let onSelect: (SearchSuggestion) -> Void

    var body: some View {

        ScrollView {

            LazyVStack(
                alignment: .leading,
                spacing: 20
            ) {

                if !viewModel.recentSearches.isEmpty {

                    RecentSearchesView(
                        searches: viewModel.recentSearches,
                        onTap: onSelect
                    )
                }

                if !viewModel.suggestions.isEmpty {

                    SearchSuggestionsView(
                        suggestions: viewModel.suggestions,
                        onTap: onSelect
                    )
                }
            }
            .padding()
        }
        .frame(maxHeight: 350)
        .background(.background)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 16
            )
        )
        .shadow(radius: 8)
        .padding(.horizontal)
    }
}

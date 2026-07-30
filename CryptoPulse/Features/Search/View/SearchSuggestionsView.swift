import SwiftUI

struct SearchSuggestionsView: View {

    // MARK: - Properties

    let suggestions: [SearchSuggestion]

    let onTap: (SearchSuggestion) -> Void

    // MARK: - Body

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: Spacing.medium
        ) {

            Text("Suggestions")
                .font(.headline)

            ForEach(suggestions) { suggestion in

                Button {

                    onTap(suggestion)

                } label: {

                    HStack(spacing: Spacing.medium) {

                        AsyncImage(
                            url: suggestion.imageURL
                        ) { image in

                            image
                                .resizable()
                                .scaledToFit()

                        } placeholder: {

                            Circle()
                                .fill(.gray.opacity(0.2))
                        }
                        .frame(
                            width: 32,
                            height: 32
                        )
                        .clipShape(Circle())

                        VStack(
                            alignment: .leading,
                            spacing: 2
                        ) {

                            Text(suggestion.name)

                            Text(suggestion.symbol.uppercased())
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Image(systemName: "arrow.up.left")
                            .foregroundStyle(.secondary)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                if suggestion.id != suggestions.last?.id {

                    Divider()
                }
            }
        }
    }
}

#Preview {

    SearchSuggestionsView(
        suggestions: [
            SearchSuggestion(
                id: "bitcoin",
                symbol: "btc",
                name: "Bitcoin",
                imageURL: URL(string: "https://assets.coingecko.com/coins/images/1/thumb/bitcoin.png")
            ),
            SearchSuggestion(
                id: "ethereum",
                symbol: "eth",
                name: "Ethereum",
                imageURL: URL(string: "https://assets.coingecko.com/coins/images/279/thumb/ethereum.png")
            )
        ]
    ) { _ in

    }
    .padding()
}

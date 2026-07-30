import SwiftUI

struct RecentSearchesView: View {

    // MARK: - Properties

    let searches: [SearchSuggestion]

    let onTap: (SearchSuggestion) -> Void

    // MARK: - Body

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: Spacing.medium
        ) {

            Text("Recent Searches")
                .font(.headline)

            ForEach(searches) { search in

                Button {

                    onTap(search)

                } label: {

                    HStack(spacing: Spacing.medium) {

                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundStyle(.secondary)

                        VStack(
                            alignment: .leading,
                            spacing: 2
                        ) {

                            Text(search.name)

                            Text(search.symbol.uppercased())
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                if search.id != searches.last?.id {

                    Divider()
                }
            }
        }
    }
}

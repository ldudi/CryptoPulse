import SwiftUI

struct PortfolioSummaryView: View {

    let state: PortfolioState

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Text("Total Value")
                .font(.headline)
            Text("$\(state.totalValue, specifier: "%.2f")")
                .font(.title)

            HStack(spacing: Spacing.medium) {
                VStack(alignment: .leading) {
                    Text("Assets")
                        .font(.subheadline)
                    Text("\(state.assetCount)")
                        .font(.body)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Total Coins")
                        .font(.subheadline)
                    Text("\(state.totalCoins, specifier: "%.4f")")
                        .font(.body)
                }
            }

            if let largest = state.largestHolding {
                HStack(spacing: Spacing.small) {
                    Image(systemName: AppIcon.chart)
                        .foregroundColor(AppColors.primaryText)
                    Text("Largest Holding:")
                        .font(.subheadline)
                    Text("\(largest.name) (\(largest.quantity, specifier: "%.4f"))")
                        .font(.body)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppColors.secondaryBackground)
        )
    }
}

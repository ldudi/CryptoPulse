import SwiftUI

struct EmptyPortfolioView: View {

    var body: some View {
        EmptyStateView(
            image: AppIcon.portfolio,
            title: "No Holdings",
            message: "Add coins to your portfolio from the Market screen."
        )
    }
}

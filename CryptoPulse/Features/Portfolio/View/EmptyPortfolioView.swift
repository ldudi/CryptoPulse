import SwiftUI

struct EmptyPortfolioView: View {

    var body: some View {
        ContentUnavailableView(
            "No Holdings",
            systemImage: AppIcon.portfolio
        ) {
            Text("Add coins to your portfolio from the Market screen.")
                .multilineTextAlignment(.center)
        }
    }
}

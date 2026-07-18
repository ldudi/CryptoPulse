import SwiftUI

struct MainTabView: View {

    @Environment(DIContainer.self)
    private var container

    var body: some View {

        @Bindable var coordinator = container.appCoordinator

        TabView(selection: $coordinator.selectedTab) {

            MarketView(
                viewModel: container.featureDependencies
                    .makeMarketViewModel()
            )
            .tabItem {
                Label(
                    "Market",
                    systemImage: "chart.line.uptrend.xyaxis"
                )
            }
            .tag(AppCoordinator.Tab.market)

            PortfolioView(
                viewModel: container.featureDependencies
                    .makePortfolioViewModel()
            )
            .tabItem {
                Label(
                    "Portfolio",
                    systemImage: "briefcase.fill"
                )
            }
            .tag(AppCoordinator.Tab.portfolio)
        }
    }
}

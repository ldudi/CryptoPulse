import SwiftUI

struct MainTabView: View {
    @Environment(DIContainer.self) private var container
    
    var body: some View {
        TabView(selection: $container.appCoordinator.selectedTab) {
            // Market tab
            NavigationStack {
                MarketView(
                    viewModel: container.featureDependencies.makeMarketViewModel()
                )
            }
            .tabItem {
                Image(systemName: "chart.line.uptrend.xyaxis")
                Text("Market")
            }
            .tag(AppCoordinator.Tab.market)
            
            // Portfolio tab
            NavigationStack {
                PortfolioView(
                    viewModel: container.featureDependencies.makePortfolioViewModel()
                )
            }
            .tabItem {
                Image(systemName: "briefcase.fill")
                Text("Portfolio")
            }
            .tag(AppCoordinator.Tab.portfolio)
            
            // Search tab
            NavigationStack {
                SearchView(
                    coinRepository: container.featureDependencies.makeCoinRepository(),
                    onCoinSelected: { coinID in
                        container.appCoordinator.navigate(to: .coinDetail(coinID))
                    }
                )
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(AppCoordinator.Tab.search)
        }
    }
}

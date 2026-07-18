import SwiftUI
import Observation

struct RootView: View {

    @Environment(DIContainer.self)
    private var container

    var body: some View {

        @Bindable var coordinator = container.appCoordinator

        NavigationStack(path: $coordinator.path) {
            rootDestination
                .navigationDestination(
                    for: AppCoordinator.Route.self
                ) { route in

                    switch route {

                    case .launch:
                        LaunchView()

                    case .splash:
                        SplashView()

                    case .home:
                        MarketView(
                            viewModel: container.featureDependencies.makeMarketViewModel()
                        )

                    case .coinDetail(let coinID):
                        CoinDetailView(
                            viewModel: container.featureDependencies.makeCoinDetailViewModel(
                                coinID: coinID
                            )
                        )

                    case .portfolio:
                        PortfolioView(
                            viewModel: container.featureDependencies.makePortfolioViewModel()
                        )
                    }
                }
        }
    }

    @ViewBuilder
    private var rootDestination: some View {

        switch container.appCoordinator.root {

        case .launch:
            LaunchView()

        case .splash:
            SplashView()

        case .home:
            MarketView(
                viewModel: container.featureDependencies.makeMarketViewModel()
            )

        case .coinDetail(let coinID):
            CoinDetailView(
                viewModel: container.featureDependencies.makeCoinDetailViewModel(
                    coinID: coinID
                )
            )

        case .portfolio:
            PortfolioView(
                viewModel: container.featureDependencies.makePortfolioViewModel()
            )
        }
    }
}

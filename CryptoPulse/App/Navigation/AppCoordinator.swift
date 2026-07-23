import Foundation
import Observation

@Observable
final class AppCoordinator {

    // MARK: - Root

    enum Root {
        case launch
        case splash
        case tabs
    }

    // MARK: - Stack Routes

    enum Route: Hashable {
        case coinDetail(String)
    }

    // MARK: - Tab

    enum Tab {
        case market
        case portfolio
    }

    var root: Root = .launch
    var path: [Route] = []
    var selectedTab: Tab = .market

    // MARK: - Root Navigation

    func showLaunch() {
        root = .launch
        path.removeAll()
    }

    func showSplash() {
        root = .splash
        path.removeAll()
    }

    func showHome() {
        root = .tabs
        path.removeAll()
    }

    // MARK: - Stack Navigation

    func navigate(to route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}

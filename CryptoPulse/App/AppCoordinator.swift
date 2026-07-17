import Observation

@Observable
final class AppCoordinator {

    enum Route: Hashable {

        case launch
        case splash
        case home

        case coinDetail(String)

        case portfolio
    }

    // MARK: - Navigation

    var path: [Route] = []

    var root: Route = .launch

    // MARK: - Root Navigation

    func showHome() {
        root = .home
    }

    func showSplash() {
        root = .splash
    }

    func showPortfolio() {
        root = .portfolio
    }

    // MARK: - Stack Navigation

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    func reset() {
        root = .launch
        path.removeAll()
    }
}

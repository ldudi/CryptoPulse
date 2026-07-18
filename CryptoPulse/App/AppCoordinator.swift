import Foundation
import Observation

@Observable
final class AppCoordinator {

    // MARK: - Navigation State

    var root: Route = .launch
    var path: [Route] = []

    // MARK: - Routes

    enum Route: Hashable {
        case launch
        case splash
        case home
        case coinDetail(String)
        case portfolio
    }

    // MARK: - Root Navigation

    func setRoot(_ route: Route) {
        root = route
        path.removeAll()
    }

    // MARK: - Stack Navigation
    
    func showSplash() {
        root = .splash
    }

    func showHome() {
        root = .home
    }

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

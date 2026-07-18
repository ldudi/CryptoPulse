import Foundation

@Observable
final class AppCoordinator {
    
    // MARK: - Dependencies
    
    private let diContainer: DIContainer
    
    // MARK: - State
    
    var selectedTab: TabSelection = .market
    
    // MARK: - Init
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    
    // MARK: - Public API
    
    func start() {
        // Navigation will be handled by the tab view
    }
    
    func selectTab(_ tab: TabSelection) {
        selectedTab = tab
    }
}

// MARK: - TabSelection

enum TabSelection: String, CaseIterable, Sendable {
    case market
    case portfolio
    case settings
    
    var title: String {
        switch self {
        case .market:
            return "Market"
        case .portfolio:
            return "Portfolio"
        case .settings:
            return "Settings"
        }
    }
    
    var systemImage: String {
        switch self {
        case .market:
            return "chart.line.uptrend.xyaxis"
        case .portfolio:
            return "briefcase"
        case .settings:
            return "gear"
        }
    }
}

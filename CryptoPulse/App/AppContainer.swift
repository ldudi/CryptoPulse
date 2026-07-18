import Foundation

@Observable
final class AppContainer {
    
    // MARK: - Dependencies
    
    private let diContainer: DIContainer
    
    // MARK: - Coordinators
    
    private(set) var appCoordinator: AppCoordinator!
    
    // MARK: - Init
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
        setupCoordinators()
    }
    
    // MARK: - Private API
    
    private func setupCoordinators() {
        appCoordinator = AppCoordinator(diContainer: diContainer)
    }
}

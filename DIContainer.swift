import Foundation

@Observable
final class DIContainer {
    
    // MARK: - Dependencies
    
    private(set) var appDependencies: AppDependencies!
    
    // MARK: - Init
    
    init() {
        setupDependencies()
    }
    
    // MARK: - Private API
    
    private func setupDependencies() {
        // Create a single persistence controller
        let persistence = PersistenceController.shared
        
        // Create app dependencies with proper initialization
        appDependencies = AppDependencies(
            configuration: AppConfiguration(),
            persistence: persistence
        )
    }
}

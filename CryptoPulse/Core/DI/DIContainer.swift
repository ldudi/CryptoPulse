import Foundation

@Observable
final class DIContainer {

    // MARK: - Configuration

    let configuration: AppConfiguration

    // MARK: - Coordinator

    let coordinator: AppCoordinator

    // MARK: - Dependencies

    let app: AppDependencies

    let features: FeatureDependencies

    init(
        configuration: AppConfiguration = .live,
        persistence: PersistenceController
    ) {

        self.configuration = configuration

        self.coordinator = AppCoordinator()

        self.app = AppDependencies(
            configuration: configuration,
            persistence: persistence
        )

        self.features = FeatureDependencies(
            appDependencies: app
        )
    }
}

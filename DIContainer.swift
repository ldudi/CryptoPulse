import Foundation

@Observable
final class DIContainer {

    let appDependencies: AppDependencies
    let appCoordinator: AppCoordinator
    let features: FeatureDependencies

    init(
        persistence: PersistenceController = .shared,
        configuration: AppConfiguration = AppConfiguration()
    ) {

        self.appDependencies = AppDependencies(
            configuration: configuration,
            persistence: persistence
        )

        self.appCoordinator = AppCoordinator(diContainer: self)

        self.features = FeatureDependencies(
            appDependencies: appDependencies
        )
    }
}

import Foundation
import Observation

@Observable
final class DIContainer {

    // MARK: - Core

    let appDependencies: AppDependencies
    let featureDependencies: FeatureDependencies

    // MARK: - Navigation

    let appCoordinator: AppCoordinator

    // MARK: - Initializer

    init(
        persistence: PersistenceController,
        configuration: AppConfiguration = .live
    ) {
        let appDependencies = AppDependencies(
            configuration: configuration,
            persistence: persistence
        )

        self.appDependencies = appDependencies

        self.featureDependencies = FeatureDependencies(
            appDependencies: appDependencies
        )

        self.appCoordinator = AppCoordinator()
    }
}

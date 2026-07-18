import SwiftUI

struct LaunchView: View {

    @Environment(DIContainer.self)
    private var container

    var body: some View {
        ProgressView()
            .task {
                try? await Task.sleep(for: .seconds(1))
                container.appCoordinator.showSplash()
            }
    }
}

//
//  LaunchView.swift
//

import SwiftUI

struct LaunchView: View {

    @Environment(DIContainer.self)
    private var container

    var body: some View {

        ProgressView()

            .task {

                try? await Task.sleep(
                    for: .seconds(1)
                )

                container.coordinator.showSplash()
            }
    }
}

#Preview {

    LaunchView()
}
//
//  LaunchView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation

//
//  SplashView.swift
//

import SwiftUI

struct SplashView: View {

    @Environment(DIContainer.self)
    private var container

    var body: some View {

        VStack(spacing: 24) {

            Image(systemName: "bitcoinsign.circle.fill")

                .font(.system(size: 80))

            Text("CryptoPulse")

                .font(.largeTitle.bold())

            ProgressView()
        }

        .task {

            try? await Task.sleep(
                for: .seconds(2)
            )

            container.coordinator.showHome()
        }
    }
}

#Preview {

    SplashView()
}
//
//  SplashView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation

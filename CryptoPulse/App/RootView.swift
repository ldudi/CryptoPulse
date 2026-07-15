//
//  RootView.swift
//

//
//  RootView.swift
//  CryptoPulse
//

import SwiftUI
import Observation

struct RootView: View {

    @Environment(DIContainer.self)
    private var container

    var body: some View {

        @Bindable var coordinator = container.coordinator

        NavigationStack(path: $coordinator.path) {

            rootDestination

                .navigationDestination(
                    for: AppCoordinator.Route.self
                ) { route in

                    switch route {

                    case .launch:
                        LaunchView()

                    case .splash:
                        SplashView()

                    case .home:
                        SplashView()
//                        HomeView()
                    }
                }
        }
    }

    @ViewBuilder
    private var rootDestination: some View {

        switch container.coordinator.root {

        case .launch:
            LaunchView()

        case .splash:
            SplashView()

        case .home:
            SplashView()
//            HomeView()
        }
    }
}
//
//  RootView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation

//
//  AppCoordinator.swift
//

import Observation

@Observable
final class AppCoordinator {

    enum Route: Hashable {

        case home

        case splash

        case launch
    }

    var path: [Route] = []

    var root: Route = .launch

    func showHome() {

        root = .home
    }

    func showSplash() {

        root = .splash
    }

    func reset() {

        path.removeAll()
    }

}
//
//  AppCoordinator.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation

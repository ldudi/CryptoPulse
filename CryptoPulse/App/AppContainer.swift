import Foundation

@Observable
final class AppContainer {

    let environment: AppEnvironment

    init(
        environment: AppEnvironment
    ) {

        self.environment = environment
    }
}

extension AppContainer {

    static let live = AppContainer(
        environment: .current
    )
}
////
////  AppContainer.swift
////  CryptoPulse
////
////  Created by Labhesh Dudi on 15/07/26.
////
//
//import Foundation

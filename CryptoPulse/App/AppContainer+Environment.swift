import SwiftUI

private struct AppContainerKey: EnvironmentKey {

    static let defaultValue = AppContainer.live
}

extension EnvironmentValues {

    var appContainer: AppContainer {

        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}
//
//  AppContainer+Environment.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation

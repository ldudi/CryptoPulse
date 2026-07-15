//
//  AppDependencies.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  AppDependencies.swift
//

import Foundation

struct AppDependencies {

    let configuration: AppConfiguration

    let logger: AppLogger

    init(
        configuration: AppConfiguration
    ) {

        self.configuration = configuration

        self.logger = LoggerFactory.shared
    }
}

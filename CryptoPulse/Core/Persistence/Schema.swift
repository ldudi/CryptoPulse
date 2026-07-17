//
//  Schema.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  Schema.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi.
//

import SwiftData

enum AppSchema {

    static var schema: Schema {

        Schema([
            PortfolioHoldingEntity.self
        ])
    }
}

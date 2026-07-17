//
//  LoggerFactory.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  LoggerFactory.swift
//

//
//  LoggerFactory.swift
//  CryptoPulse
//

import Foundation

enum LoggerFactory {

    static func makeLogger(
        category: LogCategory = .app
    ) -> AppLogger {

        OSLogger(
            defaultCategory: category
        )
    }
}

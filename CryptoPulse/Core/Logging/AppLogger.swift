//
//  AppLogger.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  AppLogger.swift
//

import Foundation

protocol AppLogger {

    func log(
        _ message: String,
        level: LogLevel,
        category: LogCategory
    )

    func debug(
        _ message: String,
        category: LogCategory
    )

    func info(
        _ message: String,
        category: LogCategory
    )

    func warning(
        _ message: String,
        category: LogCategory
    )

    func error(
        _ message: String,
        category: LogCategory
    )

    func critical(
        _ message: String,
        category: LogCategory
    )
}

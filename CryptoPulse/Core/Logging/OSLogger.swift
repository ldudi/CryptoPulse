//
//  OSLogger.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  OSLogger.swift
//

import Foundation
import OSLog

final class OSLogger: AppLogger {

    private let subsystem = Bundle.main.bundleIdentifier ?? "CryptoPulse"

    func log(
        _ message: String,
        level: LogLevel,
        category: LogCategory
    ) {

        let logger = Logger(
            subsystem: subsystem,
            category: category.rawValue
        )

        switch level {

        case .trace:

            logger.trace("\(message)")

        case .debug:

            logger.debug("\(message)")

        case .info:

            logger.info("\(message)")

        case .warning:

            logger.warning("\(message)")

        case .error:

            logger.error("\(message)")

        case .critical:

            logger.critical("\(message)")
        }
    }

    func debug(
        _ message: String,
        category: LogCategory
    ) {

        log(
            message,
            level: .debug,
            category: category
        )
    }

    func info(
        _ message: String,
        category: LogCategory
    ) {

        log(
            message,
            level: .info,
            category: category
        )
    }

    func warning(
        _ message: String,
        category: LogCategory
    ) {

        log(
            message,
            level: .warning,
            category: category
        )
    }

    func error(
        _ message: String,
        category: LogCategory
    ) {

        log(
            message,
            level: .error,
            category: category
        )
    }

    func critical(
        _ message: String,
        category: LogCategory
    ) {

        log(
            message,
            level: .critical,
            category: category
        )
    }
}

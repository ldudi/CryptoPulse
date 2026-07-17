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

final class OSLogger: AppLogger, @unchecked Sendable {

    // MARK: - Properties

    private let defaultCategory: LogCategory

    private let subsystem = Bundle.main.bundleIdentifier ?? "CryptoPulse"

    private lazy var loggers: [LogCategory: Logger] = {

        Dictionary(
            uniqueKeysWithValues:

            LogCategory.allCases.map {

                (
                    $0,

                    Logger(
                        subsystem: subsystem,
                        category: $0.rawValue
                    )
                )
            }
        )

    }()

    // MARK: - Initializer

    init(
        defaultCategory: LogCategory = .app
    ) {

        self.defaultCategory = defaultCategory
    }

    // MARK: - Private

    private func log(

        _ message: String,

        level: LogLevel,

        category: LogCategory,

        file: String,

        function: String,

        line: Int

    ) {

        guard let logger = loggers[category] else {
            return
        }

        let formattedMessage =
        "[\(file):\(line)] \(function) - \(message)"

        switch level {

        case .trace:

            logger.trace("\(formattedMessage, privacy: .public)")

        case .debug:

            logger.debug("\(formattedMessage, privacy: .public)")

        case .info:

            logger.info("\(formattedMessage, privacy: .public)")

        case .warning:

            logger.warning("\(formattedMessage, privacy: .public)")

        case .error:

            logger.error("\(formattedMessage, privacy: .public)")

        case .critical:

            logger.critical("\(formattedMessage, privacy: .public)")
        }
    }

    // MARK: - AppLogger

    func debug(
        _ message: String,
        category: LogCategory? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {

        log(
            message,
            level: .debug,
            category: category ?? defaultCategory,
            file: file,
            function: function,
            line: line
        )
    }

    func info(
        _ message: String,
        category: LogCategory? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {

        log(
            message,
            level: .info,
            category: category ?? defaultCategory,
            file: file,
            function: function,
            line: line
        )
    }

    func warning(
        _ message: String,
        category: LogCategory? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {

        log(
            message,
            level: .warning,
            category: category ?? defaultCategory,
            file: file,
            function: function,
            line: line
        )
    }

    func error(
        _ message: String,
        category: LogCategory? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {

        log(
            message,
            level: .error,
            category: category ?? defaultCategory,
            file: file,
            function: function,
            line: line
        )
    }

    func critical(
        _ message: String,
        category: LogCategory? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {

        log(
            message,
            level: .critical,
            category: category ?? defaultCategory,
            file: file,
            function: function,
            line: line
        )
    }
}

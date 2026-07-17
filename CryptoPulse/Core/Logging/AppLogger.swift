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
//
//  AppLogger.swift
//  CryptoPulse
//

import Foundation

import Foundation

protocol AppLogger: Sendable {

    func debug(
        _ message: String,
        category: LogCategory?,
        file: String,
        function: String,
        line: Int
    )

    func info(
        _ message: String,
        category: LogCategory?,
        file: String,
        function: String,
        line: Int
    )

    func warning(
        _ message: String,
        category: LogCategory?,
        file: String,
        function: String,
        line: Int
    )

    func error(
        _ message: String,
        category: LogCategory?,
        file: String,
        function: String,
        line: Int
    )

    func critical(
        _ message: String,
        category: LogCategory?,
        file: String,
        function: String,
        line: Int
    )
}

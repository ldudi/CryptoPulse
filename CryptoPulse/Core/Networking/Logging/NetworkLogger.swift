//
//  NetworkLogger.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  NetworkLogger.swift
//

import Foundation
import OSLog

final class NetworkLogger {

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "CryptoPulse",
        category: "Networking"
    )

    func logRequest(
        _ request: URLRequest
    ) {

        logger.info(
            """
            ➡️ Request

            \(request.httpMethod ?? "")

            \(request.url?.absoluteString ?? "")
            """
        )
    }

    func logResponse(
        response: HTTPURLResponse,
        data: Data
    ) {

        logger.info(
            """
            ⬅️ Response

            Status: \(response.statusCode)

            URL:

            \(response.url?.absoluteString ?? "")
            """
        )
    }

    func logError(
        _ error: Error
    ) {

        logger.error(
            """
            ❌ Error

            \(error.localizedDescription)
            """
        )
    }
}

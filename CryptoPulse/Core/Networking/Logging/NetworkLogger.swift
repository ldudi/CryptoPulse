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

        if let jsonObject = try? JSONSerialization.jsonObject(with: data),
           let prettyData = try? JSONSerialization.data(
                withJSONObject: jsonObject,
                options: [.prettyPrinted]
           ),
           let jsonString = String(data: prettyData, encoding: .utf8) {

            logger.info(
                """
                📦 Response Body

                \(jsonString)
                """
            )
        } else if let body = String(data: data, encoding: .utf8) {

            logger.info(
                """
                📦 Response Body

                \(body)
                """
            )
        } else {
            logger.error("Unable to decode response body.")
        }
    }

//    func logResponse(
//        response: HTTPURLResponse,
//        data: Data
//    ) {
//
//        logger.info(
//            """
//            ⬅️ Response
//
//            Status: \(response.statusCode)
//
//            URL:
//
//            \(response.url?.absoluteString ?? "")
//            """
//        )
//    }

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

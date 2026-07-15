//
//  ResponseValidator.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  ResponseValidator.swift
//

import Foundation

enum ResponseValidator {

    static func validate(
        _ response: HTTPURLResponse
    ) throws {

        guard let statusCode = HTTPStatusCode(
            rawValue: response.statusCode
        ) else {

            throw NetworkError.serverError(
                response.statusCode
            )
        }

        guard statusCode.isSuccess else {

            switch statusCode {

            case .unauthorized:

                throw NetworkError.unauthorized

            case .forbidden:

                throw NetworkError.forbidden

            case .notFound:

                throw NetworkError.notFound

            default:

                throw NetworkError.serverError(
                    statusCode.rawValue
                )
            }
        }
    }
}

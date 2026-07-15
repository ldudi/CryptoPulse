//
//  NetworkError.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  NetworkError.swift
//

import Foundation

enum NetworkError: LocalizedError {

    case invalidURL

    case invalidResponse

    case decoding(Error)

    case encoding(Error)

    case requestFailed(Error)

    case serverError(Int)

    case unauthorized

    case forbidden

    case notFound

    case timeout

    case cancelled

    case unknown

    var errorDescription: String? {

        switch self {

        case .invalidURL:
            return "Invalid URL."

        case .invalidResponse:
            return "Invalid server response."

        case .decoding(let error):
            return error.localizedDescription

        case .encoding(let error):
            return error.localizedDescription

        case .requestFailed(let error):
            return error.localizedDescription

        case .serverError(let code):
            return "Server Error \(code)"

        case .unauthorized:
            return "Unauthorized."

        case .forbidden:
            return "Forbidden."

        case .notFound:
            return "Not Found."

        case .timeout:
            return "Request timed out."

        case .cancelled:
            return "Request cancelled."

        case .unknown:
            return "Unknown Error."
        }
    }
}

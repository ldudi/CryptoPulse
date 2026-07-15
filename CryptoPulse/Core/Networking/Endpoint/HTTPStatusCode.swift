//
//  HTTPStatusCode.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  HTTPStatusCode.swift
//

import Foundation

enum HTTPStatusCode: Int {

    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204

    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case unprocessableEntity = 422

    case internalServerError = 500
    case badGateway = 502
    case serviceUnavailable = 503

    var isSuccess: Bool {
        (200...299).contains(rawValue)
    }
}

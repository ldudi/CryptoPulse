//
//  RequestInterceptor.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  RequestInterceptor.swift
//

import Foundation

protocol RequestInterceptor {

    func intercept(
        _ request: URLRequest
    ) async throws -> URLRequest
}

// MARK: - Default Implementation

struct DefaultRequestInterceptor: RequestInterceptor {

    func intercept(
        _ request: URLRequest
    ) async throws -> URLRequest {

        request
    }
}

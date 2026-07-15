//
//  RetryPolicy.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  RetryPolicy.swift
//  CryptoPulse
//

import Foundation

struct RetryPolicy {

    /// Maximum retry attempts.
    let maxRetries: Int

    /// Base delay in seconds.
    let baseDelay: TimeInterval

    /// Retry only for these status codes.
    let retryableStatusCodes: Set<Int>

    init(
        maxRetries: Int = 3,
        baseDelay: TimeInterval = 0.5,
        retryableStatusCodes: Set<Int> = [408, 429, 500, 502, 503, 504]
    ) {
        self.maxRetries = maxRetries
        self.baseDelay = baseDelay
        self.retryableStatusCodes = retryableStatusCodes
    }

    func shouldRetry(
        attempt: Int,
        statusCode: Int?
    ) -> Bool {

        guard attempt < maxRetries else {
            return false
        }

        guard let statusCode else {
            return false
        }

        return retryableStatusCodes.contains(statusCode)
    }

    func delay(for attempt: Int) -> TimeInterval {

        baseDelay * pow(2, Double(attempt))
    }

    static let `default` = RetryPolicy()
}

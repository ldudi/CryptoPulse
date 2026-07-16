//
//  MockAPIClient.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//

import Foundation

final class MockAPIClient: APIClient {

    var response: Any?

    var error: Error?

    func request<Response>(
        _ endpoint: Endpoint<Response>
    ) async throws -> Response where Response : Decodable {

        if let error {

            throw error
        }

        return response as! Response
    }
}

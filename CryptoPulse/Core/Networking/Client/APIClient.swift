//
//  APIClient.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  APIClient.swift
//

import Foundation

protocol APIClient {

    func request<Response: Decodable>(
        _ endpoint: Endpoint<Response>
    ) async throws -> Response
}

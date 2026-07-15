//
//  RequestBuilder.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  RequestBuilder.swift
//

import Foundation

enum RequestBuilder {

    static func build<Response>(

        endpoint: Endpoint<Response>,

        configuration: APIConfiguration

    ) throws -> URLRequest {

        guard var components = URLComponents(

            url: configuration.baseURL.appendingPathComponent(endpoint.path),

            resolvingAgainstBaseURL: false

        ) else {

            throw NetworkError.invalidURL
        }

        components.queryItems = endpoint.queryItems.isEmpty

            ? nil

            : endpoint.queryItems

        guard let url = components.url else {

            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue

        request.timeoutInterval = configuration.timeout

        request.httpBody = endpoint.body

        configuration.headers.forEach {

            request.setValue($1, forHTTPHeaderField: $0)
        }

        endpoint.headers.forEach {

            request.setValue($1, forHTTPHeaderField: $0)
        }

        return request
    }
}

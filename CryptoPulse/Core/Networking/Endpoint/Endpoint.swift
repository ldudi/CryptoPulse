//
//  Endpoint.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  Endpoint.swift
//

import Foundation

struct Endpoint<Response: Decodable> {

    let path: String

    let method: HTTPMethod

    let queryItems: [URLQueryItem]

    let headers: [String: String]

    let body: Data?

    init(

        path: String,

        method: HTTPMethod = .get,

        queryItems: [URLQueryItem] = [],

        headers: [String: String] = [:],

        body: Data? = nil

    ) {

        self.path = path

        self.method = method

        self.queryItems = queryItems

        self.headers = headers

        self.body = body
    }
}

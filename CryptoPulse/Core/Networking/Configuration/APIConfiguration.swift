//
//  APIConfiguration.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  APIConfiguration.swift
//

import Foundation

struct APIConfiguration {

    let baseURL: URL

    let timeout: TimeInterval

    let headers: [String: String]

    static let live = APIConfiguration(

        baseURL: AppConfiguration.live.apiBaseURL,

        timeout: 30,

        headers: [

            "Accept": "application/json",

            "Content-Type": "application/json"
        ]
    )
}

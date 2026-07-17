//
//  CoinEndpoints.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  CoinEndpoints.swift
//

import Foundation

enum CoinEndpoints {

    static func markets(
        request: MarketRequest = MarketRequest()
    ) -> Endpoint<[CoinDTO]> {

        Endpoint(

            path: "coins/markets",

            queryItems: [

                URLQueryItem(
                    name: "vs_currency",
                    value: request.currency.rawValue
                ),

                URLQueryItem(
                    name: "order",
                    value: request.order.rawValue
                ),

                URLQueryItem(
                    name: "per_page",
                    value: "\(request.perPage)"
                ),

                URLQueryItem(
                    name: "page",
                    value: "\(request.page)"
                ),

                URLQueryItem(
                    name: "sparkline",
                    value: request.includeSparkline.description
                ),

                URLQueryItem(
                    name: "price_change_percentage",
                    value: request.priceChangePercentage.rawValue
                )
            ]
        )
    }
}

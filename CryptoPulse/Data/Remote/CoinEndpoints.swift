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
        request: MarketRequest = .init()
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

    static func coinDetail(
        id: String
    ) -> Endpoint<CoinDetailDTO> {

        Endpoint(

            path: "coins/\(id)",

            queryItems: [

                URLQueryItem(
                    name: "localization",
                    value: "false"
                ),

                URLQueryItem(
                    name: "tickers",
                    value: "false"
                ),

                URLQueryItem(
                    name: "market_data",
                    value: "true"
                ),

                URLQueryItem(
                    name: "community_data",
                    value: "false"
                ),

                URLQueryItem(
                    name: "developer_data",
                    value: "false"
                ),

                URLQueryItem(
                    name: "sparkline",
                    value: "false"
                )
            ]
        )
    }
}

//
//  JSONDecoder+Extensions.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 15/07/26.
//
//
//import Foundation
//
//  JSONDecoder+Extensions.swift
//

import Foundation

extension JSONDecoder {

    static let apiDecoder: JSONDecoder = {

        let decoder = JSONDecoder()

        return decoder
    }()
}

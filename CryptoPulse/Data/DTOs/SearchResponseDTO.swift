//
//  SearchResponseDTO.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 30/07/26.
//

import Foundation

struct SearchResponseDTO: Decodable {

    let coins: [SearchCoinDTO]
}

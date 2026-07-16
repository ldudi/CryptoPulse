//
//  XCTestCase+Extensions.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//

import Foundation
import XCTest

extension XCTestCase {

    func wait(
        seconds: Double
    ) async {

        try? await Task.sleep(
            for: .seconds(seconds)
        )
    }
}

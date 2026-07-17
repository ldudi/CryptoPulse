//
//  NumberFormatter+Extensions.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
import Foundation

extension Double {

    var currency: String {
        formatted(.currency(code: "USD"))
    }

    var abbreviated: String {

        let formatter = ByteCountFormatter()
        formatter.countStyle = .decimal

        let number = abs(self)

        switch number {

        case 1_000_000_000_000...:
            return String(format: "%.2fT", self / 1_000_000_000_000)

        case 1_000_000_000...:
            return String(format: "%.2fB", self / 1_000_000_000)

        case 1_000_000...:
            return String(format: "%.2fM", self / 1_000_000)

        case 1_000...:
            return String(format: "%.2fK", self / 1_000)

        default:
            return String(format: "%.2f", self)
        }
    }

    var percentage: String {
        String(format: "%.2f%%", self)
    }
}

//
//  Double+Formatting.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//

import Foundation

extension Double {

    func asCurrency() -> String {
        formatted(
            .currency(code: "USD")
            .precision(.fractionLength(2))
        )
    }

    func asPercentage() -> String {
        formatted(
            .percent
            .precision(.fractionLength(2))
        )
    }

    func asNumber() -> String {
        formatted(
            .number
            .precision(.fractionLength(2))
        )
    }
}

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

extension Double {

    func asAbbreviated() -> String {

        let number = abs(self)
        let sign = self < 0 ? "-" : ""

        switch number {

        case 1_000_000_000_000...:
            return "\(sign)\(String(format: "%.2f", number / 1_000_000_000_000))T"

        case 1_000_000_000...:
            return "\(sign)\(String(format: "%.2f", number / 1_000_000_000))B"

        case 1_000_000...:
            return "\(sign)\(String(format: "%.2f", number / 1_000_000))M"

        case 1_000...:
            return "\(sign)\(String(format: "%.2f", number / 1_000))K"

        default:
            return String(format: "%.2f", self)
        }
    }
}

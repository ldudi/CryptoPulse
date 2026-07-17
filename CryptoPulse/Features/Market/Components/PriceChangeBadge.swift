//
//  PriceChangeBadge.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//  PriceChangeBadge.swift
//  CryptoPulse
//

import SwiftUI

struct PriceChangeBadge: View {

    let percentage: Double

    private var isPositive: Bool {

        percentage >= 0
    }

    private var text: String {

        String(
            format: "%.2f%%",
            percentage
        )
    }

    var body: some View {

        Text(text)

            .font(.caption.weight(.semibold))

            .padding(.horizontal, 8)

            .padding(.vertical, 4)

            .foregroundStyle(
                isPositive ? .green : .red
            )

            .background {

                Capsule()

                    .fill(
                        (isPositive ? Color.green : Color.red)
                            .opacity(0.15)
                    )
            }
    }
}

#Preview {

    VStack(spacing: 20) {

        PriceChangeBadge(
            percentage: 8.73
        )

        PriceChangeBadge(
            percentage: -3.41
        )
    }
}

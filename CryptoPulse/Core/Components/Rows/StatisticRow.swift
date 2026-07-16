//
//  StatisticRow.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  StatisticRow.swift
//

import SwiftUI

struct StatisticRow: View {

    let title: String

    let value: String

    var body: some View {

        HStack {

            Text(title)
                .font(Typography.body)

            Spacer()

            Text(value)
                .font(Typography.headline)
        }
        .padding(.vertical, Spacing.small)
    }
}

#Preview {

    StatisticRow(
        title: "Market Cap",
        value: "$4.1T"
    )
    .padding()
}

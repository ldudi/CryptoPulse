//
//  StatisticCard.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  StatisticCard.swift
//  CryptoPulse
//

import SwiftUI

struct StatisticCard: View {

    let title: String

    let value: String

    var change: String?

    var isPositive: Bool?

    var body: some View {

        CardView {

            VStack(
                alignment: .leading,
                spacing: Spacing.small
            ) {

                Text(title)

                    .font(Typography.caption)

                    .foregroundStyle(
                        AppColors.secondaryText
                    )

                Text(value)

                    .font(Typography.title)

                if let change {

                    HStack {

                        Image(
                            systemName: (isPositive ?? true)
                            ? AppIcon.arrowUp
                            : AppIcon.arrowDown
                        )

                        Text(change)
                    }

                    .font(Typography.footnote)

                    .foregroundStyle(

                        (isPositive ?? true)

                        ? AppColors.success

                        : AppColors.error
                    )
                }
            }

            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
        }
    }
}

#Preview {

    VStack {

        StatisticCard(
            title: "Bitcoin",
            value: "$118,500",
            change: "+2.4%",
            isPositive: true
        )

        StatisticCard(
            title: "Ethereum",
            value: "$3,400",
            change: "-4.1%",
            isPositive: false
        )

        StatisticCard(
            title: "Market Cap",
            value: "$4.2T"
        )

    }
    .padding()
}

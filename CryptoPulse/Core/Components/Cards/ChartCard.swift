//
//  ChartCard.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  ChartCard.swift
//  CryptoPulse
//

import SwiftUI

struct ChartCard: View {

    let title: String

    var body: some View {

        CardView {

            VStack(
                alignment: .leading,
                spacing: Spacing.medium
            ) {

                Text(title)

                    .font(Typography.title2)

                RoundedRectangle(
                    cornerRadius: Radius.medium
                )

                .fill(
                    AppColors.border
                )

                .frame(height: 220)

                .overlay {

                    VStack {

                        Image(
                            systemName: AppIcon.chart
                        )

                        Text("Chart Placeholder")

                            .font(
                                Typography.caption
                            )
                    }
                }
            }
        }
    }
}

#Preview {

    ChartCard(
        title: "Bitcoin Price"
    )
    .padding()
}

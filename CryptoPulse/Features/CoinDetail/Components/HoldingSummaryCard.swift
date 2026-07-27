//
//  HoldingSummaryCard.swift
//  CryptoPulse
//

import SwiftUI

struct HoldingSummaryCard: View {

    let holding: PortfolioHolding
    let currentPrice: Double
    let onEdit: () -> Void

    private var currentValue: Double {
        holding.quantity * currentPrice
    }

    private var investedValue: Double {
        holding.quantity * holding.averageBuyPrice
    }

    private var profitLoss: Double {
        currentValue - investedValue
    }

    private var profitColor: Color {
        profitLoss >= 0 ? .green : .red
    }

    var body: some View {

        VStack(alignment: .leading, spacing: Spacing.medium) {

            HStack {

                VStack(alignment: .leading, spacing: 4) {

                    Text("Your Holding")
                        .font(Typography.title2)

                    Text("Track your portfolio performance")
                        .font(Typography.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button("Edit") {
                    onEdit()
                }
                .buttonStyle(.bordered)
            }

            Divider()

            DetailRow(
                title: "Quantity",
                value: holding.quantity.asNumber()
            )

            DetailRow(
                title: "Average Buy",
                value: holding.averageBuyPrice.asCurrency()
            )

            DetailRow(
                title: "Current Value",
                value: currentValue.asCurrency()
            )

            DetailRow(
                title: "Profit / Loss",
                value: profitLoss.asCurrency(),
                valueColor: profitColor
            )
        }
        .padding()
        .background(AppColors.secondaryBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: Radius.large)
        )
        .appShadow(AppShadows.medium)
    }
}

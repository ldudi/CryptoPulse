//
//  CoinDescriptionCard.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 27/07/26.
//

import Foundation
import SwiftUI

struct CoinDescriptionCard: View {

    let description: String

    @State
    private var isExpanded = false

    var body: some View {

        VStack(alignment: .leading, spacing: Spacing.medium) {

            Text("About")
                .font(Typography.title3)
                .fontWeight(.bold)

            Text(description)
                .font(Typography.body)
                .foregroundStyle(.secondary)
                .lineLimit(isExpanded ? nil : 5)
                .animation(.snappy, value: isExpanded)

            Button(isExpanded ? "Show Less" : "Read More") {

                withAnimation(.snappy) {
                    isExpanded.toggle()
                }

            }
            .buttonStyle(.plain)
            .foregroundStyle(AppColors.accent)

        }
        .padding()
        .background(AppColors.secondaryBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: Radius.large)
        )
        .appShadow(AppShadows.medium)
    }
}

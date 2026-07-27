//
//  EmptyHoldingCard.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 27/07/26.
//

import Foundation
import SwiftUI

struct EmptyHoldingCard: View {

    let onAdd: () -> Void

    var body: some View {

        VStack(spacing: Spacing.medium) {

            Image(systemName: "wallet.pass")
                .font(.system(size: 36))
                .foregroundStyle(AppColors.accent)

            Text("No Holding Added")
                .font(Typography.title3)
                .fontWeight(.semibold)

            Text("Track your investment by adding your portfolio position.")
                .font(Typography.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button("Add Holding") {
                onAdd()
            }
            .buttonStyle(.borderedProminent)

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .padding(.horizontal)
        .background(AppColors.secondaryBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: Radius.large)
        )
        .appShadow(AppShadows.medium)
    }
}

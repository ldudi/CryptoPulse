//
//  EmptyStateView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  EmptyStateView.swift
//  CryptoPulse
//

import SwiftUI

struct EmptyStateView: View {

    let image: String

    let title: String

    let message: String

    var body: some View {

        VStack(spacing: Spacing.large) {

            Image(systemName: image)

                .font(.system(size: 70))

                .foregroundStyle(AppColors.secondaryText)

            Text(title)

                .font(Typography.title2)

            Text(message)

                .font(Typography.body)

                .foregroundStyle(AppColors.secondaryText)

                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {

    EmptyStateView(
        image: AppIcon.watchlist,
        title: "No Watchlist",
        message: "Start following your favourite cryptocurrencies."
    )
}

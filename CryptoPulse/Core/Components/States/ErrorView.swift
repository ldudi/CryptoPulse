//
//  ErrorView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  ErrorView.swift
//  CryptoPulse
//

import SwiftUI

struct ErrorView: View {

    let title: String

    let message: String

    var buttonTitle: String = "Try Again"

    let action: (() -> Void)?

    var body: some View {

        VStack(spacing: Spacing.large) {

            Image(systemName: AppIcon.error)

                .font(.system(size: 60))

                .foregroundStyle(AppColors.error)

            Text(title)

                .font(Typography.title)

            Text(message)

                .font(Typography.body)

                .foregroundStyle(AppColors.secondaryText)

                .multilineTextAlignment(.center)

            if let action {

                AppButton(
                    title: buttonTitle
                ) {

                    action()
                }
                .frame(maxWidth: 220)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {

    ErrorView(
        title: "Network Error",
        message: "Unable to connect to CoinGecko.",
        action: {}
    )
}

//
//  PrimaryButton.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  AppButton.swift
//  CryptoPulse
//

import SwiftUI

struct AppButton: View {

    let title: String

    var style: AppButtonStyle = .primary

    var isLoading: Bool = false

    var isEnabled: Bool = true

    let action: () -> Void

    var body: some View {

        Button {

            action()

        } label: {

            ZStack {

                if isLoading {

                    ProgressView()

                } else {

                    Text(title)

                        .font(Typography.headline)

                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, Spacing.small)
            .background(style.backgroundColor)
            .foregroundStyle(style.foregroundColor)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: Radius.medium
                )
            )
            .overlay {

                RoundedRectangle(
                    cornerRadius: Radius.medium
                )
                .stroke(
                    style.borderColor,
                    lineWidth: 1
                )
            }
        }
        .disabled(
            !isEnabled || isLoading
        )
        .opacity(
            isEnabled ? 1 : 0.45
        )
        .animation(
            AppTheme.animation,
            value: isLoading
        )
    }
}

#Preview {

    VStack(spacing: 20) {

        AppButton(
            title: "Buy"
        ) {

        }

        AppButton(
            title: "Sell",
            style: .secondary
        ) {

        }

        AppButton(
            title: "Delete",
            style: .destructive
        ) {

        }

        AppButton(
            title: "Outline",
            style: .outline
        ) {

        }

        AppButton(
            title: "Loading",
            isLoading: true
        ) {

        }
    }
    .padding()
}

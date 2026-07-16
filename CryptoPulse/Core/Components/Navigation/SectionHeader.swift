//
//  SectionHeader.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  SectionHeader.swift
//

import SwiftUI

struct SectionHeader: View {

    let title: String

    var subtitle: String?

    var actionTitle: String?

    var action: (() -> Void)?

    var body: some View {

        HStack(alignment: .bottom) {

            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                Text(title)
                    .font(Typography.title2)

                if let subtitle {

                    Text(subtitle)
                        .font(Typography.caption)
                        .foregroundStyle(
                            AppColors.secondaryText
                        )
                }
            }

            Spacer()

            if let actionTitle,
               let action {

                Button(actionTitle) {

                    action()
                }
                .font(Typography.caption)
            }
        }
        .padding(.horizontal, AppTheme.horizontalPadding)
    }
}

#Preview {

    VStack(spacing: 24) {

        SectionHeader(
            title: "Markets"
        )

        SectionHeader(
            title: "Trending",
            subtitle: "Top coins today"
        )

        SectionHeader(
            title: "Watchlist",
            subtitle: "12 Coins",
            actionTitle: "See All",
            action: {}
        )
    }
}
